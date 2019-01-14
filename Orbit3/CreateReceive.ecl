import ut;

EXPORT CreateReceive(
				string UpdateType,
				string ItemName,
				string ptoken,							
				string SourceName,
				string ReceiveDate,
				string MediaType = 'SFTP',
				string ReceivingType = 'Contribution', 
				string ServerInfo = 'Test-Env'
	
				) := module

//string currdatetime := STD.Date.SecondsToString(STD.Date.CurrentSeconds(true), '%Y%m%d%H%M%S');

//Create Receive instance

Inputrec := record
string UpdateType { xpath('UpdateType')} := UpdateType ;
string HpccWorkUnit { xpath('HpccWorkUnit')} := '1200';
string ItemName { xpath('ItemName')} := ItemName;
string MediaType { xpath('MediaType' )} := MediaType;
string ReceiveDate { xpath('ReceiveDate' )} := ReceiveDate;
string ReceivingType { xpath('ReceivingType')} := ReceivingType;
string ServerInfo {xpath('ServerInfo' )} := ServerInfo;
string SourceName {xpath('SourceName' )} := SourceName;

end;

 rBuilds := RECORD
		Inputrec	 CreateReceiveReceivingReq	{XPATH('CreateReceiveReceivingReq') };
	END;

rCreateReceiveRequest	:= RECORD
   string ptoken { xpath('Token')} := ptoken;
		rBuilds		OrbRequest {XPATH('Request')};
	END;
	
	 rBuildrequest := RECORD
		rCreateReceiveRequest Orbrequest	{XPATH('request') };
	END;

	
rStatus := RECORD
	STRING	Status {XPATH('CreateReceiveResponse/CreateReceiveResult/Result/RecordCreateReceive/Status')};
	STRING	Message {XPATH('CreateReceiveResponse/CreateReceiveResult/Result/RecordCreateReceive/Message')};
	STRING ReceiveInstanceId {XPATH('CreateReceiveResponse/CreateReceiveResult/Result/RecordCreateReceive/Result/ReceiveInstanceId')};

	end;
	
export retcode := SOAPCALL ( 
         
			Orbit3.EnvironmentVariables.serviceurl,
		'CreateReceive',
		rBuildrequest,
		rStatus,
		NAMESPACE(Orbit3.EnvironmentVariables.namespace ),
		LITERAL,
		SOAPACTION(Orbit3.EnvironmentVariables.soapactionprefix + 'PR/CreateReceive'),
		LOG
	) ;	

end;	
