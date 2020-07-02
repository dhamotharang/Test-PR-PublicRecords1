EXPORT Orbit_GetCandidates ( 		STRING BuildName
												, STRING BuildVersion
												, STRING TOKEN
											) := FUNCTION
	IMPORT UPI_DataBuild__dev.Orbit_Tracking as config;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'GetCandidates'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	// -
	rBuild		:= 	RECORD
		STRING			orbBuildName		 						{	XPATH('orb:BuildName'							)	}	:= 	BuildName			; 
		STRING			orbBuildVersion							{	XPATH('orb:BuildVersion'					)	}	:= 	BuildVersion	; 

	END	;
	//	-
	rBuilds		:= 	RECORD
		rBuild			orbBuild 										{	XPATH('orb:BuildData'		)	}															;								
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
	outDS_Layout := RECORD
		STRING			BuildInstanceDate						{ XPATH('BuildInstanceDate'			)	}	;
		STRING			BuildInstanceID							{ XPATH('BuildInstanceId'				)	}	;
		STRING			BuildInstanceName						{ XPATH('BuildInstanceName'			)	}	;
		STRING			BuildInstanceVersion				{ XPATH('BuildInstanceVersion'	)	}	;
		STRING			BuildStatus									{ XPATH('BuildStatus'						)	}	;
		STRING			FileName										{ XPATH('FileName'							)	}	;
		STRING			ItemId											{ XPATH('ItemId'								)	}	;
		STRING			ItemName										{ XPATH('ItemName'							)	}	;
		STRING			LandingZone									{ XPATH('LandingZone'						)	}	;
		STRING			ReceiveDate									{ XPATH('ReceiveDate'						)	}	;
		STRING			ReceivingID									{ XPATH('ReceivingID'						)	}	;
		STRING			ReceivingStatus							{ XPATH('ReceivingStatus'				)	}	;
		STRING			SourceName									{ XPATH('SourceName'						)	}	;
	END	;
	
	rCandR := RECORD
		DATASET(outDS_Layout)	outDS							{ XPATH('CandidateInstance'			)	}	;
	END	;
	//-
	rBuildData := RECORD
		STRING			orbBuildName		 						{	XPATH('BuildName'							)	}	; 
		STRING			orbBuildVersion							{	XPATH('BuildVersion'					)	}	; 
		rCandR			CandidatesR									{ XPATH('CandidateInstances'		)	}	;
	END	;
	//-	
	rBuildsR	:=	RECORD
		rBuildData		BuildData								{ XPATH('BuildData'								)	}	;
	END	;
	//-	
	rResponse :=	RECORD
		rBuildsR		BuildsComponents					{ XPATH('BuildComponents'					)	}	;
	END;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		config.TargetURL
													,	config.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(config.OrbitRR(sService)	)
													,	NAMESPACE(config.Namespace_D)
													,	LITERAL
													,	SOAPACTION(config.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	AllCandidates := 	OrbitCall.BuildsComponents.BuildData.CandidatesR.outDS;
	// BuiltOnly := AllCandidates(BuildStatus = 'Built');
	// SprayedOnly := AllCandidates(BuildStatus = 'Sprayed');
	LoadedOnly := AllCandidates(BuildStatus = 'Loaded');
	AvailableOnly := AllCandidates(BuildStatus = 'BuildAvailableForUse');
	
	// RETURN AvailableOnly;	
	// RETURN AllCandidates;	
	RETURN LoadedOnly;	
	// RETURN SprayedOnly;	
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	;	
