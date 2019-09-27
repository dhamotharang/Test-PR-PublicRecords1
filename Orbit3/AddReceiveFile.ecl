import ut;

EXPORT AddReceiveFile(
				string ptoken,							
				string ReceivingId, 
				string ServerInfo = 'Test-Env'
	
				) := module

//string currdatetime := STD.Date.SecondsToString(STD.Date.CurrentSeconds(true), '%Y%m%d%H%M%S');

//Create Receive instance

Inputrec := record
string HpccWorkUnit { xpath('HpccWorkUnit')} := '1200';
string RecordCount { xpath('RecordCount')} := '1';
string ServerInfo {xpath('ServerInfo' )} := ServerInfo;
string BatchNumber { xpath('BatchNumber' )} := '';
string FilePathName {xpath('FilePathName' )} := '';
string FileType {xpath('FileType' )} := 'DATA';
end;

 rAddReceiveFileReceiveFileReq := RECORD
		Inputrec	 AddReceiveFileReceiveFileReq	{XPATH('ReceiveFiles/AddReceiveFileReceiveFileReq') };
			string ReceivingId {xpath('ReceivingId' )} := ReceivingId;

	END;
	
	rAddReceiveFileReceivingReq := RECORD
	rAddReceiveFileReceiveFileReq AddReceiveFileReceiveFileReq {xpath('AddReceiveFileReceivingReq' )}; 
	end;

rAddReceiveRequest	:= RECORD
	    string ptoken { xpath('Token')} := ptoken;

		rAddReceiveFileReceivingReq		OrbRequest {XPATH('Request')};
	END;
	
	 rBuildrequest := RECORD
		rAddReceiveRequest Orbrequest	{XPATH('request') };
	END;

	
rStatus := RECORD
	STRING	Status {XPATH('AddReceiveFileResponse/AddReceiveFileResult/Result/RecordAddReceiveFile/Status')};
	STRING	Message {XPATH('AddReceiveFileResponse/AddReceiveFileResult/Result/RecordAddReceiveFile/Message')};

	end;
	
export retcode := SOAPCALL ( 
         
			Orbit3.EnvironmentVariables.serviceurl,
		'AddReceiveFile',
		rBuildrequest,
		rStatus,
		NAMESPACE(Orbit3.EnvironmentVariables.namespace ),
		LITERAL,
		SOAPACTION(Orbit3.EnvironmentVariables.soapactionprefix + 'PR/AddReceiveFile'),
		LOG
	) ;	

end;	
