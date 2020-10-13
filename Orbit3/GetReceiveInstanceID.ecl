
EXPORT GetReceiveInstanceID (
         string FilePathName,
				string ptoken
		
				) := module



//Get Build instance

Inputrec := record
string FilePathName { xpath('FilePathName')} := FilePathName ;
string StencilName { xpath('StencilName')} := 'Public Records' ;


end;

 rBuilds := RECORD
		Inputrec	 GetReceiveDetailsReceiving	{XPATH('GetReceiveDetailsReceiving') };
	END;

rGetBuildRequest	:= RECORD
   string ptoken { xpath('Token')} := ptoken;
		rBuilds		OrbRequest {XPATH('Request')};
	END;
	
	 rBuildrequest := RECORD
		rGetBuildRequest Orbrequest	{XPATH('request') };
	END;

	
rStatus := RECORD
	STRING	ResultStatus {XPATH('GetReceiveDetailsResponse/GetReceiveDetailsResult/Result/RecordGetReceiveDetails/Status')};
	STRING ReceiveInstanceId {XPATH('GetReceiveDetailsResponse/GetReceiveDetailsResult/Result/RecordGetReceiveDetails/Result/ReceiveInstanceId')};
      STRING ReceiveInstanceStatus {XPATH('GetReceiveDetailsResponse/GetReceiveDetailsResult/Result/RecordGetReceiveDetails/Result/Status')};
	STRING	Message {XPATH('GetReceiveDetailsResponse/GetReceiveDetailsResult/Result/RecordGetReceiveDetails/Message')};

	end;
	
export retcode := SOAPCALL ( 
         
			Orbit3.EnvironmentVariables.serviceurl,
		'GetReceiveDetails',
		rBuildrequest,
		rStatus,
		NAMESPACE(Orbit3.EnvironmentVariables.namespace ),
		LITERAL,
		SOAPACTION(Orbit3.EnvironmentVariables.soapactionprefix + 'PR/GetReceiveDetails'),
		LOG
	) ;	

end;	