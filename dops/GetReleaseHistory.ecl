// location = 'B' or 'Q' or '' or '*'
// cluster = 'N' or 'F' or '' or '*' or 'S' - Customer Support or 'FS' - FCRA Customer Support or 'T' - Customer Test
// datasetname = dataset name from dops
export GetReleaseHistory(string location,string cluster,string datasetname
													,string dopsenv = dops.constants.dopsenvironment) := function
	InputRec := record
		string location{xpath('location')} := location;
		string cluster{xpath('cluster')} := cluster;
		string dsname{xpath('dsname')} := datasetname;
		
	end;
	
	outrec := record
		string certversion {xpath('certversion')};
		string certwhenupdated {xpath('certwhenupdated')};
		string prodversion {xpath('prodversion')};
		string prodwhenupdated {xpath('prodwhenupdated')};
		string updateflag {xpath('updateflag')};
		
		
	end;
	
	soapresults := SOAPCALL(
				dops.constants.prboca.serviceurl(dopsenv,cluster),
				'GetReleaseHistory',
				InputRec,
				dataset(outrec),
				xpath('GetReleaseHistoryResponse/GetReleaseHistoryResult/VersionHistory'),
				//dataset(outrec),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/GetReleaseHistory'));
	
	
	return soapresults;
end;