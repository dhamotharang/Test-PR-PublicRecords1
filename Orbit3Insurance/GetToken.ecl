EXPORT GetToken()	:=
function
	/////////////////////////////////////////////////////////////////////////////
	rLoginParms := record
		string								ApplicationName					{xpath('ApplicationName')}										:=  trim(Orbit3Insurance.EnvironmentVariables.ApplicationName,left,right);
		string 								Username 								{xpath('Username'),					maxlength(32)}		:=	Orbit3Insurance.EnvironmentVariables.ServiceUserName;
		string								Password 								{xpath('Password'),					maxlength(32)}		:=	Orbit3Insurance.EnvironmentVariables.ServicePassword;
	end;
	rLoginRequest	:=	record
		rLoginParms 					loginRequest						{xpath('loginRequest')};
	end;
	/////////////////////////////////////////////////////////////////////////////
	rFault := record
		string								FaultCode								{xpath('faultcode'),				maxlength(36)};
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
		lResponse	:=	soapcall(Orbit3Insurance.EnvironmentVariables.ServiceURL, 
													 'Login',
													 rLoginRequest,
													 rSOAPResponse,
													 namespace(Orbit3Insurance.EnvironmentVariables.NameSpace),
													 literal,
													 soapaction(Orbit3Insurance.EnvironmentVariables.SoapActionLogin)
													);
		// xmlds := dataset([rLoginParms],rLoginRequest);
		// output(xmlds);
		// output(lResponse.LoginResponse.LoginResult.Result);
		return lResponse.LoginResponse.LoginResult.Result;	
end;