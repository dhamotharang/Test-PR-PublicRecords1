import ut;

EXPORT UpdateReceive(
				string UpdateType,
				string ItemName,
				string ptoken,							
				string SourceName,
				string ReceivingId,
				string ReceiveDate,
				string MediaType = 'SFTP',
				string ReceivingType = 'Contribution' 
	
				) := module

//string currdatetime := STD.Date.SecondsToString(STD.Date.CurrentSeconds(true), '%Y%m%d%H%M%S');

//Create Receive instance

Inputrec := record
string UpdateType { xpath('UpdateType')} := UpdateType ;
string Description { xpath('Description')} := '' ;
string ItemName { xpath('ItemName')} := ItemName;
string MediaType { xpath('MediaType' )} := MediaType;
string ReceiveDate { xpath('ReceiveDate' )} := ReceiveDate;
string ReceivingId { xpath('ReceivingId')} := ReceivingId;
string ReceivingType { xpath('ReceivingType')} := ReceivingType;
string SourceName {xpath('SourceName' )} := SourceName;
string Status {xpath('Status' )} := 'LOADED';

end;

 rBuilds := RECORD
		Inputrec	 UpdateReceiveReceivingReq	{XPATH('UpdateReceiveReceivingReq') };
	END;

rUpdateReceiveRequest	:= RECORD
   string ptoken { xpath('Token')} := ptoken;
		rBuilds		OrbRequest {XPATH('Request')};
	END;
	
	 rBuildrequest := RECORD
		rUpdateReceiveRequest Orbrequest	{XPATH('request') };
	END;

	
rStatus := RECORD
	STRING	Status {XPATH('UpdateReceiveResponse/UpdateReceiveResult/Result/RecordUpdateReceive/Status')};
	STRING	Message {XPATH('UpdateReceiveResponse/UpdateReceiveResult/Result/RecordUpdateReceive/Message')};

	end;
	
export retcode := SOAPCALL ( 
         
			Orbit3.EnvironmentVariables.serviceurl,
		'UpdateReceive',
		rBuildrequest,
		rStatus,
		NAMESPACE(Orbit3.EnvironmentVariables.namespace ),
		LITERAL,
		SOAPACTION(Orbit3.EnvironmentVariables.soapactionprefix + 'PR/UpdateReceive'),
		LOG
	) ;	

end;	
