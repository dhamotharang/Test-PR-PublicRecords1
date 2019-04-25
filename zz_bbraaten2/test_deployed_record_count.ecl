shared rec_count_lay := record
		string datasetname;
		string location;
		string cluster;
		string environment;
end;

// EXPORT test_deployed_record_count(dataset(rec_count_lay) ds_in ) := function
EXPORT test_deployed_record_count(dataset(rec_count_lay) ds_in ) := function

import dops;
	InputRec := record
		string datasetname{xpath('dataset')} := ds_in.datasetname;
		string location{xpath('location')} := ds_in.location;
		string cluster{xpath('cluster')} := ds_in.cluster;
		string environment{xpath('environment')} := ds_in.environment;
	end;
	
	outrec := record
		string superkey {xpath('superkey')};
		string logicalkey {xpath('logicalkey')};
		string buildversion {xpath('buildversion')};
		string size {xpath('size')};
		string recordcount {xpath('recordcount')};
		
	end;
	
	soapresults := SOAPCALL(
				ds_in,
				dops.constants.prboca.serviceurl('prod'),
				'GetKeyRecordCount',
				{InputRec},
				dataset(outrec),
				xpath('GetKeyRecordCountResponse/GetKeyRecordCountResult/keycount'),
				//dataset(outrec),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/GetKeyRecordCount'));
	
	
	return soapresults;
end;