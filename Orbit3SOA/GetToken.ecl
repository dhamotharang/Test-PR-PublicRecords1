

export GetToken(string pEnv = '', string orbitAPP = 'PR')	:=
module
	/////////////////////////////////////////////////////////////////////////////
	rLoginParms := record
		string								ApplicationName					{xpath('ApplicationName'),				maxlength(3)}			:=  orbitAPP;//trim(ContributionScrubsOrbit3.Constants.ApplicationName,left,right);
		string 								Username 								{xpath('Username'),								maxlength(32)}		:=	Orbit3SOA.EnvironmentVariables.username;
		string								Password 								{xpath('Password'),								maxlength(32)}		:=	Orbit3SOA.EnvironmentVariables.password;
	end;
	rLoginRequest	:=	record
		rLoginParms 					loginRequest						{xpath('loginRequest')};
	end;
	/////////////////////////////////////////////////////////////////////////////
	rFault := record
		string								FaultCode								{xpath('faultcode'),									maxlength(36)};
		string								faultstring							{xpath('faultstring')};
	end;
	rLvl2Reponse := record
		string 								Result			 						{xpath('Result')};
		string 								Status									{xpath('Status')};
		string								Message									{xpath('Message')};		
	end;
	rLvl1Response	:= record
		rLvl2Reponse					LoginResult							{xpath('LoginResult')};
	end;
	rSOAPResponse	:= 	record
		rFault								FaultRecord							{xpath('Fault')};
		rLvl1Response					LoginResponse						{xpath('LoginResponse')};
	end;

	/////////////////////////////////////////////////////////////////////////////
	export	typeof(rLvl2Reponse.Result) GetLoginToken()	:=
	function
		lResponse	:=	soapcall(Orbit3SOA.EnvironmentVariables.serviceurl, 
													 'Login',
													 rLoginRequest,
													 rSOAPResponse,
													 namespace('http://lexisnexis.com/Orbit/'),
													 literal,
													 soapaction('http://lexisnexis.com/Orbit/IOrbitServiceBase/Login')
													);
																				 
		assert(lResponse.LoginResponse.LoginResult.Status <> 'Fail',
					 'ContributionScrubsOrbit3.Login - ' + lResponse.LoginResponse.LoginResult.Message,
					 fail
					);
		// xmlds := dataset([rLoginParms],rLoginRequest);
		// output(xmlds);
		// output(lResponse.LoginResponse.LoginResult.Result);
		return lResponse.LoginResponse.LoginResult.Result;	
	end;
end;
