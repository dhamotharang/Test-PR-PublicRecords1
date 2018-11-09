// Function to get live version of keys from DOPS
		
// Parameters

// datasetname - same as dataset name in the package
// location - B for Boca, A for Alpharetta
// cluster - Boca: F - FCRA, N - nonFCRA, B - Boolean
//						Alpharetta: F - FCRA, N - nonFCRA, S - Customer Support, T - Customer Test, FS - FCRA Customer Support
//						Health Care: H - Health care, HU - HC UAT, HT - HC Customer test
// environment - 'Q' - QA/Cert or 'P' - Prod

import dops;
export GetKeysByDataset(
												string datasetname
											 ,string locationflag
											 ,string clusterflag
											 ,string environmentflag
											 ,string dopsenv = dops.constants.dopsenvironment
											 ) := function
	
	rGetKeysbyDatasetRequest := record
		string datasetname{xpath('datasetname')} := datasetname;
		string location{xpath('location')} := locationflag;
		string cluster{xpath('cluster')} := clusterflag;
		string environment{xpath('environment')} := environmentflag;
		
		
	end;
	
	rGetKeysbyDatasetResponse := record,maxlength(50000)
		string superkey {xpath('superkey')};
		string logicalkey {xpath('logicalkey')};
		string dname {xpath('dname')};
		string updateflag {xpath('updateflag')};
	end;
	
	dGetKeysbyDatasetResponse := SOAPCALL(
				dops.constants.prboca.serviceurl(dopsenv,clusterflag),
				'GetKeysbyDataset',
				rGetKeysbyDatasetRequest,
				dataset(rGetKeysbyDatasetResponse),
				xpath('GetKeysbyDatasetResponse/GetKeysbyDatasetResult/roxielist'),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/GetKeysbyDataset'));
	
	

	return dGetKeysbyDatasetResponse;
	

	
end;