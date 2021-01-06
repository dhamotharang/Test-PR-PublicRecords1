EXPORT Orbit_AddBuildsToABuild (STRING BuildName
												, STRING BuildVersion
												,	STRING newBuildName
												, STRING newBuildVersion
												, STRING Token
												, STRING OrbitEnv
															) := FUNCTION
IMPORT UPI_DataBuild.Orbit_Tracking as configQA;
IMPORT UPI_DataBuild.Orbit_TrackingPROD as configPROD;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'AddComponentsToABuild'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rCompAdd	:=	RECORD
		STRING			orbBuildName2							{	XPATH('orb:BuildName'						)	}	:=  newBuildName		;	// 'ReceivingId'
		STRING			orbBuildVersion2					{	XPATH('orb:BuildVersion'				)	}	:=  newBuildVersion	;	// 'ReceivingId'
	END	;
	// -
	rComp			:=	RECORD
		rCompAdd		orbComponentToAdd					{ XPATH('orb:ComponentToAdd'			)	};
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
													,	NAMESPACE(configQA.Namespace_D)
													,	LITERAL
													,	SOAPACTION(configQA.SoapPath(sService))
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCallPROD	:=	SOAPCALL(		configPROD.targetURL
													,	configPROD.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(configPROD.OrbitRR(sService)	)
													,	NAMESPACE(configPROD.Namespace_D)
													,	LITERAL
													,	SOAPACTION(configPROD.SoapPath(sService))
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	RETURN	if(OrbitEnv = 'QA', (UNSIGNED4)OrbitCallQA.BuildsResponse.InstanceToAdd.BuildId,
															(UNSIGNED4)OrbitCallPROD.BuildsResponse.InstanceToAdd.BuildId);
	// output(rRequest);
	// RETURN	OrbitCall;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End CreateBuild Function	
