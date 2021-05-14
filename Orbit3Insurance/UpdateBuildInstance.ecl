import STD;
EXPORT UpdateBuildInstance(string		pLoginToken,
															DATASET(Layouts.OrbitUpdateBuildInstanceLayout)	pBuildInfo,						
															String 	pBuildStatus,
								dataset(Layouts.OrbitPlatformUpdateLayout) platformupdates = dataset([],Layouts.OrbitPlatformUpdateLayout),
			

															String 	pHpccWorkUnit = workunit) := function					


 
	rUpdateRequest := RECORD
		string 	BuildName											{xpath('BuildName')};
		string 	BuildVersion									{xpath('BuildVersion')};
		string 	BuildStatus										{xpath('BuildStatus')};
		string  HpccWorkUnit									{xpath('HpccWorkUnit')};
		dataset(Layouts.OrbitPlatformUpdateLayout)	PlatformStatusUpdates	{xpath('PlatformStatusUpdates/PlatformStatusUpdate')};
	end;

	fCreateBuildUpdateInstanceRequest() := FUNCTION
		 rUpdateRequest tUpdateBuildInstance(Layouts.OrbitUpdateBuildInstanceLayout pBuildInfo) := TRANSFORM
				SELF.BuildName			:= trim(pBuildInfo.BuildInstanceName,LEFT,RIGHT);
				SELF.BuildVersion		:= trim(pBuildInfo.BuildInstanceVersion,LEFT,RIGHT);
				SELF.BuildStatus		:= pBuildStatus;
				SELF.HpccWorkUnit		:= pHpccWorkUnit;
				Self.PlatformStatusUpdates	:= platformupdates;
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
	
	 #IF(STD.System.Util.PlatformVersionCheck('7.8')) 
	 Orbit3Insurance.Layouts.AdditionalNamespacesLayout;
	 #END
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
	
		rStatus := RECORD
		STRING	Status	{XPATH('UpdateBuildInstanceResponse/UpdateBuildInstanceResult/Result/RecordResponseUpdateBuildInstance/Status')};
	  STRING	Message {XPATH('UpdateBuildInstanceResponse/UpdateBuildInstanceResult/Result/RecordResponseUpdateBuildInstance/Message')};

end;



		
		rStatus lResponse	:=	  SOAPCALL(Orbit3Insurance.EnvironmentVariables.serviceURL,
																					 'UpdateBuildInstance',
																					 rRequestCapsule,
																					 rStatus,
																					 NAMESPACE(Orbit3Insurance.EnvironmentVariables.Namespace),
																					 LITERAL,
																					 SOAPACTION(Orbit3Insurance.EnvironmentVariables.SOAPActionPrefix + 'UpdateBuildInstance'),
																					 LOG
																					);
		
		RETURN	lResponse;
	// END;

END;