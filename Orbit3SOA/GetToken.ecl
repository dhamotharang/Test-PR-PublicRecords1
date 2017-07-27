export GetToken(string pEnv = '', string orbitAPP = 'PR') := function

	InputRec := record
		string userName {xpath('username')} := Orbit3SOA.EnvironmentVariables.username;
		string password {xpath('password')} := Orbit3SOA.EnvironmentVariables.password;
		string applicationName {xpath('applicationName')} := orbitAPP;
	end;

	OutRec := RECORD 
		string outdata {xpath('LoginResponse/LoginResult')};
	end;

	retval := SOAPCALL(
		if (pEnv = 'Prod',
			Orbit3SOA.EnvironmentVariables.serviceurlprod,
			Orbit3SOA.EnvironmentVariables.serviceurl),
		'Login',
		InputRec,
		OutRec,
		NAMESPACE(Orbit3SOA.EnvironmentVariables.namespace),
		LITERAL,
		SOAPACTION(Orbit3SOA.EnvironmentVariables.soapactionprefix + 'Login')
	);

	return retval.outdata;

end;

