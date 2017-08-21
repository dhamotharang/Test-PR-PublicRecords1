export GetToken(string pEnv = '', string orbitAPP = 'PR') := function

InputRec := 
record
   string applicationName {xpath('ApplicationName')} := orbitAPP;
   string userName {xpath('Username')} := Orbit3.EnvironmentVariables.username;
   string password {xpath('Password')} := Orbit3.EnvironmentVariables.password;
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
		
			Orbit3.EnvironmentVariables.serviceurl,
		'Login',
		rLoginRequest,
		rResponse,
		NAMESPACE(Orbit3.EnvironmentVariables.namespace ),
		LITERAL,
		SOAPACTION(Orbit3.EnvironmentVariables.soapactionprefix + 'Base/Login'),
		LOG
	):GLOBAL;



	return retval.orbitToken;

end;

