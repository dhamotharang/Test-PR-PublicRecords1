EXPORT ReceiveItem(STRING UpdateType,
									 STRING ItemName,
									 STRING ptoken,							
									 STRING SourceName,
									 STRING ReceiveDate,
									 STRING MediaType = 'SFTP',
									 STRING ReceivingType = 'Contribution', 
									 STRING ServerInfo = EnvironmentVariables.orbitServerInfo) := MODULE

	//SOAP Request Format
	Inputrec := RECORD
		STRING UpdateType {XPATH('UpdateType')} := UpdateType ;
		STRING HpccWorkUnit {XPATH('HpccWorkUnit')} := '1200';
		STRING ItemName {XPATH('ItemName')} := ItemName;
		STRING MediaType {XPATH('MediaType' )} := MediaType;
		STRING ReceiveDate {XPATH('ReceiveDate' )} := ReceiveDate;
		STRING ReceivingType {XPATH('ReceivingType')} := ReceivingType;
		STRING ServerInfo {XPATH('ServerInfo' )} := ServerInfo;
		STRING SourceName {XPATH('SourceName' )} := SourceName;
	END;

	rBuilds := RECORD
		Inputrec	CreateReceiveReceivingReq	{XPATH('CreateReceiveReceivingReq')};
	END;

	rCreateReceiveRequest	:= RECORD
		STRING ptoken {XPATH('Token')} := ptoken;
		rBuilds	OrbRequest {XPATH('Request')};
	END;
	
	rBuildrequest := RECORD
		rCreateReceiveRequest Orbrequest {XPATH('request')};
	END;

	//SOAP Response Results
	rStatus := RECORD
		STRING	Status {XPATH('CreateReceiveResponse/CreateReceiveResult/Result/RecordCreateReceive/Status')};
		STRING	Message {XPATH('CreateReceiveResponse/CreateReceiveResult/Result/RecordCreateReceive/Message')};
		STRING ReceiveInstanceId {XPATH('CreateReceiveResponse/CreateReceiveResult/Result/RecordCreateReceive/Result/ReceiveInstanceId')};
	END;
	
	EXPORT retcode := SOAPCALL(Orbit3.EnvironmentVariables.serviceurl,
														 'CreateReceive',
														 rBuildrequest,
														 rStatus,
														 NAMESPACE(Orbit3.EnvironmentVariables.namespace ),
														 LITERAL,
														 SOAPACTION(Orbit3.EnvironmentVariables.soapactionprefix + 'PR/CreateReceive'),
														 LOG);
		
END;	
