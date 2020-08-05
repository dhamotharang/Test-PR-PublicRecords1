EXPORT Orbit_UpdateBuildStatus (		STRING BuildName
														, STRING BuildStatus	
														, STRING BuildVersion
														, STRING TOKEN
														, STRING Comments =''

													) := FUNCTION
	IMPORT UPI_DataBuild__dev;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'UpdateBuildStatus'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rBuild		:= 	RECORD
		STRING			orbBuildName		 						{	XPATH('orb:BuildName'							)	}	:= 	BuildName			;
		STRING			orbBuildStatus							{	XPATH('orb:BuildStatus'						)	}	:= 	BuildStatus		;
		STRING			orbBuildVersion							{	XPATH('orb:BuildVersion'					)	}	:= 	BuildVersion	;
		STRING			orbComments									{	XPATH('orb:Comments'							)	}	:= 	Comments	;
	END	;
	//	-
	rBuilds		:= 	RECORD
		rBuild			orbBuild 										{	XPATH('orb:BuildForStatusUpdate'	)	}										;								
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
	rOrbit 		:= 	RECORD
		STRING			OrbitStatusCode							{	XPATH('OrbitStatusCode'						)	}										;
		STRING			OrbitStatusDescription			{	XPATH('OrbitStatusDescription'		)	}										;	
	END;
	//-	
	rStatus 	:= 	RECORD
		STRING			Code												{	XPATH('Code'											)	}										;
		STRING			Description									{	XPATH('Description'								)	}										;
		STRING			Status											{	XPATH('Status'										)	}										;
	END	;
	//-	
	rBuildsSU	:=	RECORD
		STRING			BuildId											{	XPATH('BuildId'										)	}										;
		STRING			BuildName										{	XPATH('BuildName'									)	}										;
		STRING			BuildStatus									{	XPATH('BuildStatus'								)	}										;
		STRING			BuildVersion								{	XPATH('BuildVersion'							)	}										;
		rStatus			Status											{ XPATH('Status'										)	}										;
	END	;
	//-	
	rBuildsR	:=	RECORD
		rBuildsSU		BuildsSU										{ XPATH('BuildRespForStatusUpdate'	)	}										;
	END	;
	//-	
	rResponse :=	RECORD
		rBuildsR		BuildsR			 								{	XPATH('Builds'										)	}										;		
		STRING 			OriginalRequest							{	XPATH('OriginalRequest'						)	}										;
		rOrbit			OrbitStatus 								{	XPATH('StatusCode'								)	}										;		
	END;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		UPI_DataBuild__dev.Orbit_Tracking.TargetURL
													,	UPI_DataBuild__dev.Orbit_Tracking.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(UPI_DataBuild__dev.Orbit_Tracking.OrbitRR(sService)	)
													,	NAMESPACE(UPI_DataBuild__dev.Orbit_Tracking.Namespace_B)
													,	LITERAL
													,	SOAPACTION(UPI_DataBuild__dev.Orbit_Tracking.SoapPath(sService) )
													, RETRY(2)
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	RETURN	OrbitCall.BuildsR.BuildsSU.Status.Status;
	/*RETURN	IF ( 		OrbitCall.BuildsR.BuildsSU.BuildID = '0'
								,	'Failure - Scrub Build Instance is invalid'
								, OrbitCall.BuildsR.BuildsSU.Status.Status
							)	;*/
		// RETURN OrbitCall;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End CreateBuild Function	
