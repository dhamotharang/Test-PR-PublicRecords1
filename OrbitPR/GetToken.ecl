export GetToken(string pEnv = '', string orbitAPP = 'PR') := function

InputRec := 
record
   string applicationName {xpath('ApplicationName')} := orbitAPP;
   string userName {xpath('Username')} := OrbitPR.EnvironmentVariables.username;
   string password {xpath('Password')} := OrbitPR.EnvironmentVariables.password;
end; 

rLoginRequest	:= RECORD
		InputRec 	loginRequest						{XPATH('loginRequest')};
	END;

rResponse := record
string orbitToken {xpath('LoginResponse/LoginResult/Result')};
string Status {xpath('LoginResponse/LoginResult/Status')};
string Message {xpath('LoginResponse/LoginResult/Message')};

END;




	retval := SOAPCALL(
		
			OrbitPR.EnvironmentVariables.serviceurl,
		'Login',
		rLoginRequest,
		rResponse,
		NAMESPACE(OrbitPR.EnvironmentVariables.namespace ),
		LITERAL,
		SOAPACTION(OrbitPR.EnvironmentVariables.soapactionprefix + 'Base/Login'),
		LOG
	):GLOBAL;



	return retval.orbitToken;

end;

