EXPORT Orbit_CreateBuild ( 		STRING BuildName
											, STRING BuildStatus
											, STRING BuildVersion
											, STRING HpccWorkUnit
											, STRING MasterBuild
											, STRING TOKEN
											, STRING OrbitEnv
										) := FUNCTION										
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'CreateBuild'	;
	IMPORT ut;
	IMPORT UPI_DataBuild.Orbit_Tracking as configQA;
	IMPORT UPI_DataBuild.Orbit_TrackingPROD as configPROD;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rBuild		:= 	RECORD
		STRING			orbBuildName		 						{	XPATH('orb:BuildName'							)	}	:= 	BuildName			; 
		STRING			orbBuildStatus		 					{	XPATH('orb:BuildStatus'						)	}	:= 	BuildStatus		; 
		STRING			orbBuildVersion							{	XPATH('orb:BuildVersion'					)	}	:= 	BuildVersion	; 
		STRING			orbHpccWorkUnit							{	XPATH('orb:HpccWorkUnit'					)	}	:= 	HpccWorkUnit	;	
		STRING			orbMasterBuild							{	XPATH('orb:MasterBuild'						)	}	:= 	MasterBuild		;	
	END	;
	//	-
	rBuilds		:= 	RECORD
		rBuild			orbBuild 										{	XPATH('orb:Build'									)	}										;								
	END	;
	// -
	rLex			:= 	RECORD
		rBuilds		 	orbBuilds		 								{	XPATH('orb:Builds'								)	}										;
		STRING 			orbToken 										{	XPATH('orb:Token'									)	}	:= 	TOKEN					;	
		END	;
	// -
	rRequest	:= 	RECORD
		$.Orbit_Layouts.AdditionalNamespacesLayout;	
		rLex				lexRequest									{	XPATH('lex:request'								)	}										;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rBuild2		:= 	RECORD
		STRING			BuildId											{	XPATH('BuildId'										)	}										;
	END;
	//-	
	rBuilds2 		:= 	RECORD
		rBuild2			Build2											{	XPATH('BuildResponse'						)	}										;	
	END;
	//-
	rOrbit 		:= 	RECORD
		STRING			OrbitStatusCode							{	XPATH('OrbitStatusCode'						)	}										;
		STRING			OrbitStatusDescription			{	XPATH('OrbitStatusDescription'		)	}										;	
	END;
	//-		
	rResponse :=	RECORD
		rBuilds2		Builds2Response							{	XPATH('Builds'										)	}										;
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
													,	SOAPACTION(configQA.SoapPath(sService) )
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
													,	SOAPACTION(configPROD.SoapPath(sService) )
													, RETRY(2)
													, LOG
												)	;
	// -----------------------------------------------------------------------------------------------------------------------------------------
	// RETURN	(UNSIGNED4)OrbitCall.Builds2Response.Build2.BuildId	;
	// RETURN	OrbitCall	;
	RETURN	IF(OrbitEnv = 'QA', OrbitCallQA.Builds2Response.Build2.BuildId, OrbitCallPROD.Builds2Response.Build2.BuildId)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End CreateBuild Function	
