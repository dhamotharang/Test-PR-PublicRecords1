EXPORT GetBuildVersion(string datasetname // DOPS package name
											,string location // B - Boca, A - Alpharetta
											,string environment // N - Nonfcra, F - FCRA, S - Customer Supp, T - Customer Test, FS - FCRA Cust Support
											,string clusterflag // C - Cert, P - Prod, T - Thor
											,string dopsenv = dops.constants.dopsenvironment
											) := function

	InputRec := record
		string dsname{xpath('dsname')} := datasetname;
		string loc{xpath('loc')} := location;
		string envflag{xpath('envflag')} := environment;
		string clusterflag{xpath('clusterflag')} := clusterflag;
	end;
	
	
	outrec := record
		string retstring{xpath('GetBuildVersionResponse/GetBuildVersionResult')};
	end;

	soapresults := SOAPCALL(
				dops.constants.prboca.serviceurl(dopsenv,l_loc := location),
				'GetBuildVersion',
				InputRec,
				dataset(outrec),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/GetBuildVersion'));
				
	return soapresults[1].retstring;
											
end;