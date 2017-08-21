// location = 'B' for boca or 'A' for alpharetta or '' or '*'
// cluster = 'N' for nonfcra or 'F' for fcra or '' or '*' or 'S' - Customer Support or 'FS' - FCRA Customer Support or 'T' - Customer Test
// environment = 'Q' for qa or 'P' for prod
// datasetname = dataset name from dops
export GetKeyRecordCount(string datasetname, string location,string cluster,string environment,string dopsenv = dops.constants.dopsenvironment) := function
	InputRec := record
		string datasetname{xpath('dataset')} := datasetname;
		string location{xpath('location')} := location;
		string cluster{xpath('cluster')} := cluster;
		string environment{xpath('environment')} := environment;
	end;
	
	outrec := record
		string superkey {xpath('superkey')};
		string logicalkey {xpath('logicalkey')};
		string buildversion {xpath('buildversion')};
		string size {xpath('size')};
		string recordcount {xpath('recordcount')};
		
	end;
	
	soapresults := SOAPCALL(
				dops.constants.prboca.serviceurl(dopsenv,cluster),
				'GetKeyRecordCount',
				InputRec,
				dataset(outrec),
				xpath('GetKeyRecordCountResponse/GetKeyRecordCountResult/keycount'),
				//dataset(outrec),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/GetKeyRecordCount'));
	
	
	return soapresults;
end;