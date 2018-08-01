EXPORT UpdateBuildInstance(string		pLoginToken,
															DATASET(Layouts.OrbitUpdateBuildInstanceLayout)	pBuildInfo,						
															String 	pBuildStatus,
															String	pPlatformName,
															String	pPlatformStatus,
															String 	pHpccWorkUnit) := function					


	pPlatformStatusInfo	:=	DATASET([{ pPlatformName, pPlatformStatus }], Layouts.OrbitPlatformUpdateLayout);
 
	rUpdateRequest := RECORD
		// string 	BuildId										{xpath('BuildId')};
		string 	BuildName											{xpath('BuildName')};
		string 	BuildVersion									{xpath('BuildVersion')};
		string 	BuildStatus										{xpath('BuildStatus')};
		string  HpccWorkUnit									{xpath('HpccWorkUnit')};
		dataset(Layouts.OrbitPlatformUpdateLayout)	PlatformStatusUpdates	{xpath('PlatformStatusUpdates/PlatformStatusUpdate')};
	end;

	fCreateBuildUpdateInstanceRequest() := FUNCTION
		 rUpdateRequest tUpdateBuildInstance(Layouts.OrbitUpdateBuildInstanceLayout pBuildInfo) := TRANSFORM
				// SELF.BuildId				:= pBuildInfo.BuildInstanceId;
				SELF.BuildName			:= trim(pBuildInfo.BuildInstanceName,LEFT,RIGHT);
				SELF.BuildVersion		:= trim(pBuildInfo.BuildInstanceVersion,LEFT,RIGHT);
				SELF.BuildStatus		:= pBuildStatus;
				SELF.HpccWorkUnit		:= pHpccWorkUnit;
				Self.PlatformStatusUpdates	:= pPlatformStatusInfo;
			END;
	
		RETURN PROJECT(pBuildInfo, tUpdateBuildInstance(left));
	END;

	pRequestsPrep := fCreateBuildUpdateInstanceRequest();
  pRequests := project(pRequestsPrep, rUpdateRequest);
	
	rReceivings := RECORD
		DATASET (rUpdateRequest)	RecordRequestUpdateBuildInstance	{XPATH('RecordRequestUpdateBuildInstance')} := pRequests;
	END;

	rOrbitRequest := RECORD
		STRING 					LoginToken						{XPATH('Token'),							MAXLENGTH(36)}		:=	pLoginToken;
		rReceivings			OrbRequest						{XPATH('Request')};
	END;

	rRequestCapsule	:= RECORD
			rOrbitRequest	request								{XPATH('request')};
	END;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	rPlatformStatus	:= RECORD
		string	PlatformName									{xpath('PlatformName')};
		string	PlatformStatus								{xpath('PlatformStatus')};
	END;	
	rPlatformStatusUpdate	:= RECORD
		rPlatformStatus	PlatformStatusUpdate	{XPATH('PlatformStatusUpdate')};
	END;
	rUpdateBuild :=	RECORD
		Layouts.OrbitPlatformUpdateLayout ;
		rPlatformStatusUpdate	PlatformStatusUpdates			{XPATH('PlatformStatusUpdates')};
	END;	
	
	rOrbitResponse	:= RECORD
		rUpdateBuild			Result							{XPATH('Result')};		
		STRING						Status							{XPATH('Status')};
		STRING						Message							{XPATH('Message')};
	END;
	
  rRecordUpdateBuild := RECORD
		DATASET (rOrbitResponse)		RecordResponseUpdateBuildInstance	{XPATH('RecordResponseUpdateBuildInstance')};
	END;	
	
	rresponse	:= RECORD
		rRecordUpdateBuild Result 						{XPATH('Result')};
		STRING						Status							{XPATH('Status')};
		STRING						Message							{XPATH('Message')};
	END;
	
  rBuildResult := RECORD
		rresponse 	UpdateBuildInstanceResult	{XPATH('UpdateBuildInstanceResult')};
		STRING			Status										{XPATH('Status')};
		STRING			Message										{XPATH('Message')};
  END;	
	
	rFault    := RECORD
		STRING         FaultCode							{XPATH('faultcode')};
		STRING         FaultString						{XPATH('faultSTRING')};
	END;
	
  rSOAPResponse	:= RECORD
		rFault  			FaultRecord							{XPATH('Fault')};
		rBuildResult	UpdateBuildInstanceResponse	{XPATH('UpdateBuildInstanceResponse'), 		MAXLENGTH(81920)};
	END;

	// EXPORT 	fUpdateBuildInstance()	:= FUNCTION
	
		// SERVICE_DEBUG:= FALSE;
		// SERVICE_DEBUG:= TRUE;
		
		rSOAPResponse lResponse	:=	  SOAPCALL(Orbit3Insurance.EnvironmentVariables.serviceURL,
																					 'UpdateBuildInstance',
																					 rRequestCapsule,
																					 rSOAPResponse,
																					 NAMESPACE(Orbit3Insurance.EnvironmentVariables.Namespace),
																					 LITERAL,
																					 SOAPACTION(Orbit3Insurance.EnvironmentVariables.SOAPActionPrefix + 'UpdateBuildInstance'),
																					 LOG
																					);
		// #IF(SERVICE_DEBUG)																			
			// output(lResponse, named('UpdateBuildResponse'), OVERWRITE);
			// output(lResponse.FaultRecord.FaultCode, named('FaultCode'), OVERWRITE);
			// output(lResponse.FaultRecord.FaultString, named('FaultString'), OVERWRITE);
			// output(lResponse.XMLResponse.UpdateBuildInstanceResult.Result.RecordResponseUpdateBuildInstance[1].Result);
			// output(lResponse.XMLResponse.UpdateBuildInstanceResult.Result.RecordResponseUpdateBuildInstance[1].Status);
			// output(lResponse.XMLResponse.UpdateBuildInstanceResult.Result.RecordResponseUpdateBuildInstance[1].Message);
		// #END
	
		// xmlds := dataset([rReceivings ],rOrbitRequest - logintoken);
		// output(xmlds);
		// output(lResponse,named('updatebuildinstance'));
		RETURN	lResponse;
	// END;

END;