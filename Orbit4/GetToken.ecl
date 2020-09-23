export GetToken(string pEnv = '', string orbitAPP = 'PR') := function

InputRec := 
record
   string applicationName {xpath('ApplicationName')} := orbitAPP;
   string userName {xpath('Username')} := Orbit4.EnvironmentVariables.username;
   string password {xpath('Password')} := Orbit4.EnvironmentVariables.password;
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
		
			Orbit4.EnvironmentVariables.serviceurl,
		'Login',
		rLoginRequest,
		rResponse,
		NAMESPACE(Orbit4.EnvironmentVariables.namespace ),
		LITERAL,
		SOAPACTION(Orbit4.EnvironmentVariables.soapactionprefix + 'Base/Login'),
		LOG
	):GLOBAL;



	return retval.orbitToken;

end;

