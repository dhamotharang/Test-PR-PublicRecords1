// environment = 'P' or 'Q'
// location [optional] = 'B' or 'Q' or '' or '*'
// cluster [optional] = 'N' or 'F' or '' or '*' or 'S' - Customer Support or 'FS' - FCRA Customer Support or 'T' - Customer Test
// datasetname [optional] = dataset name from dops
// dopsenv = 'prod' or 'dev'
export GetDeployedDatasets(string environment
															,string location = ''
															,string cluster = ''
															,string datasetname = ''
															,string dopsenv = dops.constants.dopsenvironment) := function
	InputRec := record
		string envment{xpath('envment')} := environment;
		string cluster{xpath('cluster')} := cluster;
		string location{xpath('location')} := location;
		string dsname{xpath('dsname')} := datasetname;
		
	end;
	
	outrec := record
		string datasetname {xpath('datasetname')};
		string envment {xpath('envment')};
		string location {xpath('location')};
		string cluster {xpath('cluster')};
		string buildversion {xpath('buildversion')};
		string keycount {xpath('keycount')};
		string releasedate {xpath('releasedate')};
		
	end;
	
	soapresults := SOAPCALL(
				dops.constants.prboca.serviceurl(dopsenv,cluster),
				'GetDeployedDatasets',
				InputRec,
				dataset(outrec),
				xpath('GetDeployedDatasetsResponse/GetDeployedDatasetsResult/versionlist'),
				//dataset(outrec),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/GetDeployedDatasets'));
	
	
	return soapresults;
end;