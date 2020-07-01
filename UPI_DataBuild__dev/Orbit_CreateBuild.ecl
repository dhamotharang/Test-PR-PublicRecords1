IMPORT UPI_DataBuild__dev.Orbit_Tracking as config;

EXPORT Orbit_CreateBuild ( 		STRING BuildName
											, STRING BuildStatus
											, STRING BuildVersion
											, STRING HpccWorkUnit
											, STRING MasterBuild
											, STRING TOKEN
										) := FUNCTION
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'CreateBuild'	;
	IMPORT ut;
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
	OrbitCall	:=	SOAPCALL(		config.targetURL
													,	config.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(config.OrbitRR(sService)	)
													,	NAMESPACE(config.Namespace_B)
													,	LITERAL
													,	SOAPACTION(config.SoapPath(sService) )
													, RETRY(2)
													, LOG
												)	;
	// -----------------------------------------------------------------------------------------------------------------------------------------
	RETURN	(UNSIGNED4)OrbitCall.Builds2Response.Build2.BuildId	;
	// RETURN	OrbitCall	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End CreateBuild Function	
