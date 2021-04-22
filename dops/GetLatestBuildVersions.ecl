// location = 'B' for boca or 'A' for alpharetta 
// cluster = 'N' for nonfcra or 'F' for fcra or 'S' - Customer Support or 'FS' - FCRA Customer Support or 'T' - Customer Test
// environment = 'Q' for qa or 'P' for prod
// datasetname = dataset name from dops
// getkeyinfo = 0 (return only build versions); 1 - for each build version return superkey, logicalkey, size and count
export GetLatestBuildVersions(string datasetname
													,string location
													,string clusterflag
													,string environment
													,integer getkeyinfo = 0 // 1 - get key information (record count/size)
													,string dopsenv = dops.constants.dopsenvironment) := function
													
	rGetLatestBuildVersionsRequest := record
		string datasetname{xpath('dataset')} := datasetname;
		string location{xpath('location')} := location;
		string clusterflag{xpath('cluster')} := clusterflag;
		string environment{xpath('environment')} := environment;
		integer includekeys{xpath('includekeys')} := getkeyinfo;
	end;
	
	rGetLatestBuildVersionsResponse := record
		string datasetname{xpath('dataset')};
		string location{xpath('location')};
		string clusterflag{xpath('cluster')};
		string environment{xpath('envment')};
		string buildversion{xpath('buildversion')};
		string updateflag{xpath('updateflag')};
		string deployed{xpath('deployed')};
		string latestversion{xpath('latestversion')};
		string releasedate{xpath('releasedate')};
		string whencreated {xpath('whencreated')};
		string whenupdated {xpath('whenupdated')};
		string versionstatus {xpath('versionstatus')};
		string versionstatusdesc {xpath('versionstatusdesc')};
		string superkey {xpath('superkey')};
		string logicalkey {xpath('logicalkey')};
		string size {xpath('size')};
		string recordcount {xpath('recordcount')};
		
	end;
	
	dGetLatestBuildVersionsResponse := SOAPCALL(
				dops.constants.prboca.serviceurl(dopsenv,clusterflag),
				'GetLatestBuildVersions',
				rGetLatestBuildVersionsRequest,
				dataset(rGetLatestBuildVersionsResponse),
				xpath('GetLatestBuildVersionsResponse/GetLatestBuildVersionsResult/versionlist'),
				//dataset(outrec),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/GetLatestBuildVersions'));
	
	
	return dGetLatestBuildVersionsResponse;
end;