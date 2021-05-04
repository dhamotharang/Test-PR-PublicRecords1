// location = 'B' for boca or 'A' for alpharetta or '' or '*'
// cluster = 'N' for nonfcra or 'F' for fcra or '' or '*' or 'S' - Customer Support or 'FS' - FCRA Customer Support or 'T' - Customer Test

// dopsenv = 'dev' or 'prod'; dev - points to dev or prod DOPS DB
// mode:
// 1 - use from/todate based on qalive; if qa available for date range then returns prod info if available else no record
// 2 - use from/todate based on prodlive - if prod available for date range then returns qa info if available else no record
// 3 - use from/todate based on both live dates - if qa and prod available returns 1 records with qa/prod live information, if qa alone is available returns qa + prod NA, if prod alone is available returns prod + qa NA
export GetHistoricalKeyInfo(string datasetname
																,string location
																,string cluster
																//,string environment // DUS-566
																,string fromdate
																,string todate
																,string mode = '3' // default return both
																,string dopsenv = dops.constants.dopsenvironment) := function
	rRequest := record
		string datasetname{xpath('datasetname')} := datasetname;
		string location{xpath('location')} := location;
		string cluster{xpath('cluster')} := cluster;
		//string environment{xpath('environment')} := environment; // DUS-566
		string fromdate{xpath('fromdate')} := fromdate;
		string todate{xpath('todate')} := todate;
		string mode{xpath('mode')} := mode;
	end;
	
	rResponse := record
		string datasetname {xpath('datasetname')};
		string clusterflag {xpath('clusterflag')};
		string whenqalive {xpath('whenqalive')};
		string whenprodlive {xpath('whenprodlive')};
		string buildversion {xpath('buildversion')};
		string superkey {xpath('superkey')};
		string logicalkey {xpath('logicalkey')};
		
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