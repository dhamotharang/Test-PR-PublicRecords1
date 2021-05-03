IMPORT STD;

EXPORT AddItemtoBuild(STRING pLoginToken,
											STRING pBuildName,
											STRING pBuildVersion,
											STRING pBuildInstanceID,
											SET OF STRING ReceiveInstanceIds) := MODULE

	//SOAP Request Format
	rstuff := RECORD
		STRING	arrlong {XPATH('arr:long')} := '';
	END;


  Inputrec := RECORD
	  STRING BuildInstanceId {XPATH('BuildInstanceId')} := pBuildInstanceID;
		STRING BuildName {XPATH('BuildName')} := pBuildName;
		STRING BuildVersion {XPATH('BuildVersion')} := pBuildVersion;
		DATASET(rstuff)	ReceiveInstanceIds {XPATH('ReceiveInstanceIds')} :=	DATASET([ReceiveInstanceIds],rstuff);
	END;


	rBuilds := RECORD
		Inputrec	 RecordRequestAddBuildInstanceComponent	{XPATH('RecordRequestAddBuildInstanceComponent')};
	END;

	rUpdateBuildRequest	:= RECORD
		STRING ptoken {XPATH('Token')} := pLoginToken;
		rBuilds	OrbRequest {XPATH('Request')};
	END;
	
	rBuildrequest := RECORD
		#IF(STD.System.Util.PlatformVersionCheck('7.8')) 
			Orbit3.Layouts.AdditionalNamespacesLayout;
		#END
		rUpdateBuildRequest	request {XPATH('request') };
	END;
	
	//SOAP Response Results
	rStatus	:= RECORD
		STRING  Status {XPATH('AddBuildInstanceComponentResponse/AddBuildInstanceComponentResult/Result/RECORDResponseAddBuildInstanceComponent/Status')};
		STRING Message {XPATH('AddBuildInstanceComponentResponse/AddBuildInstanceComponentResult/Result/RECORDResponseAddBuildInstanceComponent/Message')};
	END;
		
	EXPORT retcode	:=  SOAPCALL(Orbit3.EnvironmentVariables.serviceurl,
																'AddBuildInstanceComponent',
																rBuildrequest,
																rStatus,
																NAMESPACE(Orbit3.EnvironmentVariables.namespace),
																LITERAL,
																SOAPACTION(Orbit3.EnvironmentVariables.soapactionprefix + 'PR/AddBuildInstanceComponent'),
																LOG);	
END;	