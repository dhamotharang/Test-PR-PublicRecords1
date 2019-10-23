import dops;
// Function - To get current build version in PRCT dops database.
// dsname - Dataset name - same as of nonfcra (regular)
// inenvment - F - FCRA, N - Nonfcra or B - Both (fcra and nonfcra)
export GetDemoBuildVersion(string dsname,string inenvment,string dopsenv = dops.constants.dopsenvironment) := function

	InputRec := record
		string dsname{xpath('dsname')} := dsname;
		string loc{xpath('loc')} := 'B';
		string envflag{xpath('envflag')} := inenvment;
		
	end;
	

	outrec := record
		string retstring{xpath('GetDemoBuildVersionResponse/GetDemoBuildVersionResult')};
	end;

	soapresults := SOAPCALL(
				dops.constants.prboca.serviceurl(dopsenv),
				'GetDemoBuildVersion',
				InputRec,
				dataset(outrec),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/GetDemoBuildVersion'));
				
	return soapresults[1].retstring;

end;