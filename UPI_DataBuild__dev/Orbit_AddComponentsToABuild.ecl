EXPORT Orbit_AddComponentsToABuild ( 		STRING BuildName
																, STRING BuildVersion
																,	STRING ReceivingID
																// , STRING BuildVersion2
																// , STRING MasterBuildId
																, STRING Token
																, STRING OrbitEnv
															) := FUNCTION
IMPORT UPI_DataBuild__dev.Orbit_Tracking as configQA;
IMPORT UPI_DataBuild__dev.Orbit_TrackingPROD as configPROD;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'AddComponentsToABuild'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rCompAdd	:=	RECORD
		STRING			orbReceivingId							{	XPATH('orb:ReceivingId'						)	}	:=  ReceivingId		;	// 'ReceivingId'
	END	;
	// -
	rComp			:=	RECORD
		rCompAdd		orbComponentToAdd						{ XPATH('orb:ComponentToAdd'				)	}										;
	END	;
	// -
	rBuild		:= 	RECORD
		STRING			orbBuildName		 						{	XPATH('orb:BuildName'							)	}	:= 	BuildName			; // 'BUILD-NAME'
		STRING			orbBuildVersion							{	XPATH('orb:BuildVersion'					)	}	:= 	BuildVersion	; // 'BUILD VERSION'
		rComp				orbComponents								{ XPATH('orb:Components'						)	}										;			
	END	;
	//	-
	rBuilds		:= 	RECORD
		rBuild			orbBuild 										{	XPATH('orb:BuildInstanceToAdd'		)	}										;								
	END	;
	// -
	rLex			:= 	RECORD
		rBuilds		 	orbBuilds		 								{	XPATH('orb:Builds'								)	}										;
		STRING 			orbToken 										{	XPATH('orb:Token'									)	}	:= 	Token					;	
		END	;
	// -
	rRequest	:= 	RECORD
		$.Orbit_Layouts.AdditionalNamespacesLayout;	
		rLex				lexRequest									{	XPATH('lex:request'								)	}										;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit 		:= 	RECORD
		STRING			OrbitStatusCode							{	XPATH('OrbitStatusCode'						)	}										;
		STRING			OrbitStatusDescription			{	XPATH('OrbitStatusDescription'		)	}										;	
	END;
	//-
	rCompAddR	:=	RECORD
		STRING			BuildId2										{	XPATH('BuildId'										)	}										;
		STRING			BuildName2									{	XPATH('BuildName'									)	}										;
		STRING			BuildVersion2								{	XPATH('BuildVersion'							)	}										;
		STRING			MasterBuildId2							{	XPATH('MasterBuildId'							)	}										;
		STRING			ReceivingId									{	XPATH('ReceivingId'								)	}										;
		STRING			Status											{	XPATH('Status'										)	}										;
	END	;
	//-
	rCompR		:=	RECORD
		rCompAddR		ComponentToAddR							{ XPATH('ComponentToAdd'						)	}										;
	END	;
	//-	
	rInstance	:=	RECORD
		STRING			BuildId											{	XPATH('BuildId'										)	}										;
		STRING			BuildName										{	XPATH('BuildName'									)	}										;
		STRING			BuildVersion								{	XPATH('BuildVersion'							)	}										;
		rCompR			ComponentsR									{ XPATH('Components'								)	}										;
		STRING			MasterBuildId								{	XPATH('MasterBuildId'							)	}										;
		STRING			Status											{	XPATH('Status'										)	}										;
	END	;
	//-	
	rBuildsR	:=	RECORD
		rInstance		InstanceToAdd								{ XPATH('BuildInstanceToAdd'				)	}										;
	END	;
	//-	
	rResponse :=	RECORD
		rBuildsR		BuildsResponse							{ XPATH('Builds'										)	}										;
		rOrbit			OrbitStatus 								{	XPATH('OrbitStatus'								)	}										;
		STRING 			OriginalRequest							{	XPATH('OriginalRequest'						)	}										;
	END;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCallQA	:=	SOAPCALL(		configQA.targetURL
													,	configQA.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(configQA.OrbitRR(sService)	)
													,	NAMESPACE(configQA.Namespace)
													,	LITERAL
													,	SOAPACTION(configQA.SoapPath(sService))
													, RETRY(2)
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCallPROD	:=	SOAPCALL(		configPROD.targetURL
													,	configPROD.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(configPROD.OrbitRR(sService)	)
													,	NAMESPACE(configPROD.Namespace)
													,	LITERAL
													,	SOAPACTION(configPROD.SoapPath(sService))
													, RETRY(2)
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	RETURN	IF(OrbitEnv = 'QA',(UNSIGNED4)OrbitCallQA.BuildsResponse.InstanceToAdd.Status,
														 (UNSIGNED4)OrbitCallPROD.BuildsResponse.InstanceToAdd.Status);
	// RETURN	(UNSIGNED4)OrbitCall.BuildsResponse.InstanceToAdd.Status;
	// RETURN OrbitCall.OrbitStatus.OrbitStatusDescription;
	// RETURN	OrbitCall;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End CreateBuild Function	
