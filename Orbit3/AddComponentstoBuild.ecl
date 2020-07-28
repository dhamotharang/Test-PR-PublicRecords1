﻿import ut,STD;

EXPORT AddComponentsToBuild(string			pLoginToken,
																	string			pBuildName,
																	string			pBuildVersion,
																	string			pEmailList,
																	dataset(Orbit3.Layouts.OrbitBuildInstanceLayout)	pBuildCandidates
																 ) := function

//SOAP Request format

///////////////////////////////////////////////////////////////////////////////////////////////
rstuff := record
		string								arrlong									{xpath('arr:long')}						:= '';
	end;


  Inputrec := record
		string								BuildName								{xpath('BuildName')}						:=	pBuildName;
		string								BuildVersion						{xpath('BuildVersion')}					:=	pBuildVersion;
		dataset(rstuff)				ReceiveInstanceIds			{xpath('ReceiveInstanceIds')}		:=	project(pBuildCandidates,transform(rstuff,self.arrlong := left.ID));
		dataset(rstuff)				BuildInstanceIds				{xpath('BuildInstanceIds')}			:=	dataset([],rstuff);
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
	
	rBatchResults	:= record
		string									BuildInstanceId				{xpath('BuildInstanceId')};
		string									BuildName							{xpath('BuildName')};
		string									BuildVersion					{xpath('BuildVersion')};
	end;
	rResult2	:= record
		rBatchResults						Result								{xpath('Result')};
		string									Status								{xpath('Status')};
		string									Message								{xpath('Message')};
	end;
	
	rRecordResponseAddBuildInstanceComponent := record
		rResult2	RecordResponseAddBuildInstanceComponent	{xpath('RecordResponseAddBuildInstanceComponent')};
	end;
	
	rResult	:= record
		rRecordResponseAddBuildInstanceComponent	Result	{xpath('Result')};	
		string									Status								{xpath('Status')};
		string									Message								{xpath('Message')};
	end;
	
	rAddBuildInstanceComponentRslt	:= record
		rResult	AddBuildInstanceComponentResult			{xpath('AddBuildInstanceComponentResult')};
	end;

rFault  :=	record
		string         					FaultCode							{xpath('faultcode')};
		string    		    			FaultString						{xpath('faultstring')};
	end;

	rStatus := RECORD
		rAddBuildInstanceComponentRslt		AddBuildInstanceComponentResponse		{xpath('AddBuildInstanceComponentResponse'), 		maxlength(300000)};
       rFault		FaultRecord													{xpath('Fault')};
end;
///////////////////////////////////////////////////////////////////////////////
	lResponse	:=  SOAPCALL (         
			Orbit3.EnvironmentVariables.serviceurl,
		'AddBuildInstanceComponent',
		rBuildrequest,
		rStatus,
		#IF(STD.System.Util.PlatformVersionCheck('7.8'))  
		                                                              NAMESPACE($.EnvironmentVariables.NameSpace),
		#ELSE
		                                                               ,NAMESPACE($.EnvironmentVariables.NameSpace + ' xmlns:orb="http://lexisnexis.com/Orbit/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays"  xmlns:i="http://www.w3.org/2001/XMLSchema-instance');
		#END
		//NAMESPACE(Orbit3.EnvironmentVariables.namespace ),
		LITERAL,
		SOAPACTION(Orbit3.EnvironmentVariables.soapactionprefix + 'PR/AddBuildInstanceComponent'),
		LOG
	) ;	

xmlds := dataset([rBuildrequest.request.OrbRequest.RecordRequestAddBuildInstanceComponent],Inputrec);
	
return lResponse.AddBuildInstanceComponentResponse.AddBuildInstanceComponentResult.Status;

	
end;	