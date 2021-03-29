EXPORT GetBuildInstance (
         string BuildName,
				string BuildVersion,
				string ptoken/*,
				string BuildInstanceId*/
		
				) := module



//Get Build instance

Inputrec := record
string BuildName { xpath('BuildName')} := BuildName ;
string BuildVersion { xpath('BuildVersion')} := BuildVersion;
//string BuildInstanceId {xpath('BuildInstanceId')} := BuildInstanceId;


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
	STRING	BuildInstanceStatus {XPATH('GetBuildInstanceResponse/GetBuildInstanceResult/Result/RecordResponseGetBuildInstance/Result/Status')};

	end;
	
export retcode := SOAPCALL ( 
         
			OrbitPR.EnvironmentVariables.serviceurl,
		'GetBuildInstance',
		rBuildrequest,
		rStatus,
		NAMESPACE(OrbitPR.EnvironmentVariables.namespace ),
		LITERAL,
		SOAPACTION(OrbitPR.EnvironmentVariables.soapactionprefix + 'PR/GetBuildInstance'),
		LOG
	) ;	

end;	