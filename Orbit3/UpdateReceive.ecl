EXPORT UpdateReceive(STRING UpdateType,
										 STRING ItemName,
										 STRING ptoken,							
										 STRING SourceName,
										 STRING ReceivingId,
										 STRING ReceiveDate,
										 STRING MediaType = 'SFTP',
										 STRING ReceivingType = 'Contribution') := MODULE


	//SOAP Request Format
	Inputrec := RECORD
		STRING UpdateType {XPATH('UpdateType')} := UpdateType ;
		STRING Description {XPATH('Description')} := '' ;
		STRING ItemName {XPATH('ItemName')} := ItemName;
		STRING MediaType {XPATH('MediaType' )} := MediaType;
		STRING ReceiveDate {XPATH('ReceiveDate' )} := ReceiveDate;
		STRING ReceivingId {XPATH('ReceivingId')} := ReceivingId;
		STRING ReceivingType {XPATH('ReceivingType')} := ReceivingType;
		STRING SourceName {XPATH('SourceName' )} := SourceName;
		STRING Status {XPATH('Status' )} := 'LOADED';
	END;

	rBuilds := RECORD
		Inputrec UpdateReceiveReceivingReq {XPATH('UpdateReceiveReceivingReq')};
	END;

	rUpdateReceiveRequest	:= RECORD
		STRING ptoken {XPATH('Token')} := ptoken;
		rBuilds	OrbRequest {XPATH('Request')};
	END;
	
	rBuildrequest := RECORD
		rUpdateReceiveRequest Orbrequest {XPATH('request')};
	END;

	//SOAP Response Results
	rStatus := RECORD
		STRING	Status {XPATH('UpdateReceiveResponse/UpdateReceiveResult/Result/RecordUpdateReceive/Status')};
		STRING	Message {XPATH('UpdateReceiveResponse/UpdateReceiveResult/Result/RecordUpdateReceive/Message')};
	END;
	
	EXPORT retcode := SOAPCALL(Orbit3.EnvironmentVariables.serviceurl,
														 'UpdateReceive',
														 rBuildrequest,
														 rStatus,
														 NAMESPACE(Orbit3.EnvironmentVariables.namespace ),
														 LITERAL,
														 SOAPACTION(Orbit3.EnvironmentVariables.soapactionprefix + 'PR/UpdateReceive'),
														 LOG);	

END;	
