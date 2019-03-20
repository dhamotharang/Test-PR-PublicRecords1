// Function - GetRoxieDependencies
// Purpose - Get the list of roxie data dependencies per environment per location
// Parameters -
// 		environment: "F" - FCRA, "N" - Nonfcra, "B" - Boolean
//		location: "B" - Boca, "A" - Alpharetta
//		datasetname [optional]: Pass the dataset name from DOPS page to get the dependencies per dataset
// 		cflag: Changeflag, provide the change reason. 
//						Code: U - Layout change, ND - New dataset, A - New keys

export GetRoxieDependencies(string environment,string location,string datasetname = 'NA',string cflag = 'NA'
															,string dopsenv = dops.constants.dopsenvironment) := function
	InputRec := record
		string envment{xpath('envment')} := environment;
		string loc{xpath('loc')} := location;
		string dname{xpath('dname')} := datasetname;
		string changeflag{xpath('changeflag')} := cflag;
		
	end;
	
	outrec := record
		string Dname {xpath('Dname')};
		string Whenupdated {xpath('Whenupdated')};
		string Logicalkey {xpath('Logicalkey')};
		string Superkey {xpath('Superkey')};
		string Changeflag {xpath('Changeflag')};
		
	end;
	
	soapresults := SOAPCALL(
				dops.constants.prboca.serviceurl(dopsenv,environment),
				'GetDependenciesList',
				InputRec,
				dataset(outrec),
				xpath('GetDependenciesListResponse/GetDependenciesListResult/deplist'),
				//dataset(outrec),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/GetDependenciesList'));
	
	
	return soapresults;
end;

