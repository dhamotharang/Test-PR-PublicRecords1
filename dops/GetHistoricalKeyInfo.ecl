// location = 'B' for boca or 'A' for alpharetta or '' or '*'
// cluster = 'N' for nonfcra or 'F' for fcra or '' or '*' or 'S' - Customer Support or 'FS' - FCRA Customer Support or 'T' - Customer Test
// environment = 'Q' for qa or 'P' for prod; this variable represents data in prod or qa roxie
// datasetname = dataset name from dops
// dopsenv = 'dev' or 'prod'; dev - points to dev or prod DOPS DB
export GetHistoricalKeyInfo(string datasetname
																,string location
																,string cluster
																,string environment
																,string fromdate
																,string todate
																,string dopsenv = dops.constants.dopsenvironment) := function
	rRequest := record
		string datasetname{xpath('datasetname')} := datasetname;
		string location{xpath('location')} := location;
		string cluster{xpath('cluster')} := cluster;
		string environment{xpath('environment')} := environment;
		string fromdate{xpath('fromdate')} := fromdate;
		string todate{xpath('todate')} := todate;
	end;
	
	rResponse := record
		string superkey {xpath('superkey')};
		string logicalkey {xpath('logicalkey')};
		string buildversion {xpath('buildversion')};
		string size {xpath('size')};
		string recordcount {xpath('recordcount')};
		string updateflag {xpath('updateflag')};
		string statuscode{xpath('statuscode')};
		string statusdescription{xpath('statusdescription')};
	end;
	
	dResponse := SOAPCALL(
				// 'http://10.176.152.203:4546/',
				dops.constants.prboca.serviceurl(dopsenv,cluster),
				'GetHistoricalKeyCount',
				rRequest,
				dataset(rResponse),
				xpath('GetHistoricalKeyCountResponse/GetHistoricalKeyCountResult/keyinfohistory'),
				//dataset(outrec),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/GetHistoricalKeyCount'));
	
	
	return dResponse;
end;