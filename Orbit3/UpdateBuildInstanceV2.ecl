//*************************************************************************************************************												
//** Attribute copied from Insurance for Orbit Profile setup in PR
//*************************************************************************************************************
EXPORT UpdateBuildInstanceV2 (string		pLoginToken,
												string		pBuildName,	
												string		pBuildVersion,
												string		pHPCCWorkunit,
												string		pBuildStatus				=	'BUILD_IN_PROGRESS',
												DATASET(Orbit3.Layouts.OrbitPlatformUpdateLayout)	pPlatform	= DATASET([], Orbit3.Layouts.OrbitPlatformUpdateLayout)				
												) := function					

 
	rUpdateRequest := RECORD
		string 	BuildName											{xpath('BuildName')}; 		  //:= pBuildName;
		string 	BuildVersion										{xpath('BuildVersion')}; 	//:= pBuildVersion;
		string 	BuildStatus										{xpath('BuildStatus')};		  //:= pBuildStatus;
		string  HpccWorkUnit									{xpath('HpccWorkUnit')}; 	  //:= pHPCCWorkunit;
		dataset(Orbit3.Layouts.OrbitPlatformUpdateLayout)	PlatformStatusUpdates	{xpath('PlatformStatusUpdates/PlatformStatusUpdate')}; //:= pPlatform;
	end;
    
  pout := PROJECT(Dataset([{pBuildName,pBuildVersion,pBuildStatus,pHPCCWorkunit,pPlatform}],rUpdateRequest), TRANSFORM(LEFT));    
  pRequests := project(pout, rUpdateRequest);

	 rReceivings := RECORD
		rUpdateRequest	RecordRequestUpdateBuildInstance	{XPATH('RecordRequestUpdateBuildInstance')} := pRequests[1];
	END;

	rOrbitRequest := RECORD
		STRING 					LoginToken						{XPATH('Token'),							MAXLENGTH(36)}		:=	pLoginToken;
		rReceivings			OrbRequest						{XPATH('Request')};
	END;

	rRequestCapsule	:= RECORD
      #IF(((__ECL_VERSION_MAJOR__ = 7) AND (__ECL_VERSION_MINOR__ >= 8)) or  (__ECL_VERSION_MAJOR__ > 7)) // 7.8 Tightened up the checking of the namespace in SOAP calls, it doesn't support multiple ones so this is in as a workaround until that is available. Unfortunately the workaround doesn't work on 7.6 hence the conditional here.
          $.Layouts.AdditionalNamespacesLayout;
      #END
			rOrbitRequest	request								{XPATH('request')};
	END;


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

rUpdateBuildInstanceResultFields	:= record
		integer4					BuildId															{xpath('BuildId')};
		string							BuildName													{xpath('BuildName')};
		string							BuildVersion										{xpath('BuildVersion')};		
		string							BuildStatus											{xpath('BuildStatus')};
		integer1					NewCoverageArea							{xpath('NewCoverageArea')};
		boolean 					ExcludeFromScorecard		{xpath('ExcludeFromScorecard')};
		boolean 					SkippedBuild										{xpath('SkippedBuild')};
		string							HpccWorkUnit										{xpath('HpccWorkUnit')};
		string							ServerInfo												{xpath('ServerInfo')};
		dataset(Layouts.OrbitPlatformUpdateLayout)	PlatformStatusUpdates {xpath('PlatformName/PlatformStatus')};		
		
	end;	
	
	rOrbitResponse	:= RECORD
		rUpdateBuildInstanceResultFields			Result		{XPATH('Result')};		
		STRING						Status																									{XPATH('Status')};
		STRING						Message																								{XPATH('Message')};
	END;
	
  rRecordUpdateBuild := RECORD
		rOrbitResponse		RecordResponseUpdateBuildInstance	{XPATH('RecordResponseUpdateBuildInstance')};
	END;	
	
	rresponse	:= RECORD
		rRecordUpdateBuild Result 			{XPATH('Result')};
		STRING						Status											{XPATH('Status')};
		STRING						Message										{XPATH('Message')};
	END;
	
  rBuildResult := RECORD
		rresponse 	UpdateBuildInstanceResult	{XPATH('UpdateBuildInstanceResult')};
		STRING			Status																						{XPATH('Status')};
		STRING			Message																					{XPATH('Message')};
  END;	
	
	rFault    := RECORD
		STRING         FaultCode								{XPATH('faultcode')};
		STRING         FaultString						{XPATH('faultSTRING')};
	END;
	
  rSOAPResponse	:= RECORD
		rFault  					FaultRecord																	{XPATH('Fault')};
		rBuildResult	UpdateBuildInstanceResponse	{XPATH('UpdateBuildInstanceResponse'), 		MAXLENGTH(81920)};
	END;

// Test Input for soap
// output(pPlatform);  
// outputXMLu := TOXML(pRequests[1]);
// output(outputXMLu);
// output(pRequests);

		rSOAPResponse lResponse	:=	  SOAPCALL(Orbit3.EnvironmentVariables.serviceURL,
																					 'UpdateBuildInstance',
																					 rRequestCapsule,
																					 rSOAPResponse,
																					 NAMESPACE(Orbit3.EnvironmentVariables.Namespace),
																					 LITERAL,
																					 SOAPACTION(Orbit3.EnvironmentVariables.SOAPActionPrefix + 'PR/UpdateBuildInstance'),
																					 LOG
																					);
	RETURN	lResponse;
	

END;