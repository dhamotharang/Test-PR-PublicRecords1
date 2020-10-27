EXPORT AddReceiveFile(STRING ptoken,							
											STRING ReceivingId, 
											STRING FilePathName = '',
											STRING ServerInfo = EnvironmentVariables.orbitServerInfo) := MODULE

	//SOAP Request Format
	Inputrec := RECORD
		STRING HpccWorkUnit {XPATH('HpccWorkUnit')} := '1200';
		STRING RecordCount {XPATH('RecordCount')} := '1';
		STRING ServerInfo {XPATH('ServerInfo' )} := ServerInfo;
		STRING BatchNumber {XPATH('BatchNumber' )} := '';
		STRING FilePathName {XPATH('FilePathName' )} := FilePathName;
		STRING FileType {XPATH('FileType' )} := 'DATA';
	END;

	rAddReceiveFileReceiveFileReq := RECORD
		Inputrec AddReceiveFileReceiveFileReq	 {XPATH('ReceiveFiles/AddReceiveFileReceiveFileReq') };
		STRING ReceivingId  {XPATH('ReceivingId' )} := ReceivingId;
	END;
	
	rAddReceiveFileReceivingReq := RECORD
		rAddReceiveFileReceiveFileReq AddReceiveFileReceiveFileReq  {XPATH('AddReceiveFileReceivingReq' )}; 
	END;

	rAddReceiveRequest	:= RECORD
	    STRING ptoken {XPATH('Token')} := ptoken;
			rAddReceiveFileReceivingReq	OrbRequest  {XPATH('Request')};
	END;
	
	rBuildrequest := RECORD
		rAddReceiveRequest Orbrequest {XPATH('request')};
	END;

	//SOAP Response Results
	rStatus := RECORD
		STRING	Status {XPATH('AddReceiveFileResponse/AddReceiveFileResult/Result/RecordAddReceiveFile/Status')};
		STRING	Message {XPATH('AddReceiveFileResponse/AddReceiveFileResult/Result/RecordAddReceiveFile/Message')};
		STRING	FilePathName {XPATH('AddReceiveFileResponse/AddReceiveFileResult/Result/RecordAddReceiveFile/Result/ReceiveFiles/AddReceiveFileReceiveFileResp')};
	END;
	
	EXPORT retcode := SOAPCALL(Orbit3.EnvironmentVariables.serviceurl,
															'AddReceiveFile',
															rBuildrequest,
															rStatus,
															NAMESPACE(Orbit3.EnvironmentVariables.namespace ),
															LITERAL,
															SOAPACTION(Orbit3.EnvironmentVariables.soapactionprefix + 'PR/AddReceiveFile'),
															LOG);
END;	
