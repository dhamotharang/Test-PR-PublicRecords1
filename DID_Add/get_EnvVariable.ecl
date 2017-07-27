export get_EnvVariable(STRING name, STRING roxie_ip='http://roxiebatch.br.seisint.com:9856') :=
FUNCTION

outrec :=
RECORD
	STRING Results {xpath('Results')};
END;


RETURN
SOAPCALL(roxie_ip,'doxie.EnvironmentVariablesService',
	    {STRING EnvironmentVariable := name}, outrec, LOG).results;
					
END;		