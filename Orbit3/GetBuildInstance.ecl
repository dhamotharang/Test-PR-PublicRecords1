EXPORT GetBuildInstance (
         string BuildName,
				string BuildVersion,
				string ptoken
		
				) := module



//Get Build instance

Inputrec := record
string BuildName { xpath('BuildName')} := BuildName ;
string BuildVersion { xpath('BuildVersion')} := BuildVersion;


end;

 rBuilds := RECORD
		Inputrec	 RecordRequestGetBuildInstance	{XPATH('RecordRequestGetBuildInstance') };
	END;

rGetBuildRequest	:= RECORD
   string ptoken { xpath('Token')} := ptoken;
		rBuilds		OrbRequest {XPATH('Request')};
	END;
	
	 rBuildrequest := RECORD
		rGetBuildRequest Orbrequest	{XPATH('request') };
	END;

	
rStatus := RECORD
	STRING	Status {XPATH('GetBuildInstanceResponse/GetBuildInstanceResult/Result/RecordResponseGetBuildInstance/Status')};
	STRING BuildId {XPATH('GetBuildInstanceResponse/GetBuildInstanceResult/Result/RecordResponseGetBuildInstance/Result/BuildInstanceId')};

	end;
	
export retcode := SOAPCALL ( 
         
			Orbit3.EnvironmentVariables.serviceurl,
		'GetBuildInstance',
		rBuildrequest,
		rStatus,
		NAMESPACE(Orbit3.EnvironmentVariables.namespace ),
		LITERAL,
		SOAPACTION(Orbit3.EnvironmentVariables.soapactionprefix + 'PR/GetBuildInstance'),
		LOG
	) ;	

end;	