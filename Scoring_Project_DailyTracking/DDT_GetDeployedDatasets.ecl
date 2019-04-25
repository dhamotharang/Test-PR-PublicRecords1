

EXPORT DDT_GetDeployedDatasets (string environment, string location = '',string cluster = '',string datasetname = '') := function

// environment = 'P' or 'Q'
// location [optional] = 'B' or 'Q' or '' or '*'
// cluster [optional] = 'N' or 'F' or '' or '*' or 'S' - Customer Support or 'FS' - FCRA Customer Support or 'T' - Customer Test
// datasetname [optional] = dataset name from dops

import dops;

	InputRec := record
		string envment{xpath('envment')} := environment;
		string cluster{xpath('cluster')} := cluster;
		string location{xpath('location')} := location;
		string dsname{xpath('dsname')} := datasetname;
		//string releasedate{xpath('releasedate')} := releasedate;
		
	end;
	
	outrec := record
			Scoring_Project_DailyTracking.Attributes.ddt_layout;
	end;
	
	soapresults := SOAPCALL(
				dops.constants.prboca.serviceurl('prod'),
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