import ut,STD;

EXPORT AddItemtoBuild(string			pLoginToken,
																	string			pBuildName,
																	string			pBuildVersion,
																	string pBuildInstanceID,
																	Set of  String ReceiveInstanceIds 
																 ) := module

//SOAP Request format

///////////////////////////////////////////////////////////////////////////////////////////////
rstuff := record
		string								arrlong									{xpath('arr:long')}						:= '';
	end;


  Inputrec := record
	 string        BuildInstanceId {xpath('BuildInstanceId')}			:=	pBuildInstanceID;
		string								BuildName								{xpath('BuildName')}						:=	pBuildName;
		string								BuildVersion						{xpath('BuildVersion')}					:=	pBuildVersion;
		dataset(rstuff)				ReceiveInstanceIds			{xpath('ReceiveInstanceIds')}		:=	dataset([ReceiveInstanceIds],rstuff) ;
	end;


 rBuilds := RECORD
		Inputrec	 RecordRequestAddBuildInstanceComponent	{XPATH('RecordRequestAddBuildInstanceComponent') };
	END;

rUpdateBuildRequest	:= RECORD
   string ptoken { xpath('Token')} := pLoginToken;
		rBuilds	OrbRequest  {XPATH('Request')};
	END;
	
	 rBuildrequest := RECORD
	   #IF(STD.System.Util.PlatformVersionCheck('7.8')) 
	 Orbit3.Layouts.AdditionalNamespacesLayout;
	 #END
		rUpdateBuildRequest	request	{XPATH('request') };
	END;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	// SOA Response Results
	
	rStatus	:= record
		string  Status  {xpath('AddBuildInstanceComponentResponse/AddBuildInstanceComponentResult/Result/RecordResponseAddBuildInstanceComponent/Status')};
		string Message {xpath('AddBuildInstanceComponentResponse/AddBuildInstanceComponentResult/Result/RecordResponseAddBuildInstanceComponent/Message')};
	end;
	
	
///////////////////////////////////////////////////////////////////////////////
	export retcode	:=  SOAPCALL (         
			Orbit3.EnvironmentVariables.serviceurl,
		'AddBuildInstanceComponent',
		rBuildrequest,
		rStatus,
		NAMESPACE(Orbit3.EnvironmentVariables.namespace ),
		LITERAL,
		SOAPACTION(Orbit3.EnvironmentVariables.soapactionprefix + 'PR/AddBuildInstanceComponent'),
		LOG
	) ;	


	
end;	
