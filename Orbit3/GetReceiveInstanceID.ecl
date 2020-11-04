EXPORT GetReceiveInstanceID(STRING FilePathName,
														STRING ptoken) := MODULE

	//SOAP Request Format
	Inputrec := RECORD
		STRING FilePathName {XPATH('FilePathName')} := FilePathName;
		STRING StencilName {XPATH('StencilName')} := 'Public Records';
	END;

	rBuilds := RECORD
		Inputrec	 GetReceiveDetailsReceiving	{XPATH('GetReceiveDetailsReceiving') };
	END;

	rGetBuildRequest := RECORD
		STRING ptoken {XPATH('Token')} := ptoken;
		rBuilds	OrbRequest {XPATH('Request')};
	END;
	
	rBuildrequest := RECORD
		rGetBuildRequest Orbrequest	{XPATH('request') };
	END;

	//SOAP Response Results
	rStatus := RECORD
		STRING	ResultStatus {XPATH('GetReceiveDetailsResponse/GetReceiveDetailsResult/Result/RecordGetReceiveDetails/Status')};
		STRING ReceiveInstanceId {XPATH('GetReceiveDetailsResponse/GetReceiveDetailsResult/Result/RecordGetReceiveDetails/Result/ReceiveInstanceId')};
		STRING ReceiveInstanceStatus {XPATH('GetReceiveDetailsResponse/GetReceiveDetailsResult/Result/RecordGetReceiveDetails/Result/Status')};
		STRING	Message {XPATH('GetReceiveDetailsResponse/GetReceiveDetailsResult/Result/RecordGetReceiveDetails/Message')};
	END;
	
	EXPORT retcode := SOAPCALL(Orbit3.EnvironmentVariables.serviceurl,
														 'GetReceiveDetails',
														 rBuildrequest,
														 rStatus,
														 NAMESPACE(Orbit3.EnvironmentVariables.namespace ),
														 LITERAL,
														 SOAPACTION(Orbit3.EnvironmentVariables.soapactionprefix + 'PR/GetReceiveDetails'),
														 LOG);	
END;	