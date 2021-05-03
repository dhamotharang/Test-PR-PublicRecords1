EXPORT Orbit_GetCandidates ( 		STRING BuildName
												, STRING BuildVersion
												, STRING TOKEN
												, STRING OrbitEnv
											) := FUNCTION
	IMPORT UPI_DataBuild__dev.Orbit_Tracking as configQA;
	IMPORT UPI_DataBuild__dev.Orbit_TrackingPROD as configPROD;
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
	OrbitCallQA	:=	SOAPCALL(		configQA.TargetURL
													,	configQA.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(configQA.OrbitRR(sService)	)
													,	NAMESPACE(configQA.Namespace_D)
													,	LITERAL
													,	SOAPACTION(configQA.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCallPROD	:=	SOAPCALL(		configPROD.TargetURL
													,	configPROD.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(configPROD.OrbitRR(sService)	)
													,	NAMESPACE(configPROD.Namespace_D)
													,	LITERAL
													,	SOAPACTION(configPROD.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	AllCandidatesQA := 	OrbitCallQA.BuildsComponents.BuildData.CandidatesR.outDS;
	AllCandidatesPROD := 	OrbitCallPROD.BuildsComponents.BuildData.CandidatesR.outDS;
	// BuiltOnly := AllCandidates(BuildStatus = 'Built');
	// SprayedOnly := AllCandidates(BuildStatus = 'Sprayed');
	LoadedOnlyQA := AllCandidatesQA(BuildStatus = 'Loaded');
	LoadedOnlyPROD := AllCandidatesPROD(BuildStatus = 'Loaded');
	AvailableOnlyQA := AllCandidatesQA(BuildStatus = 'BuildAvailableForUse');
	AvailableOnlyPROD := AllCandidatesPROD(BuildStatus = 'BuildAvailableForUse');
	
	// RETURN AvailableOnly;	
	// RETURN AllCandidates;	
	RETURN IF(OrbitEnv = 'QA', LoadedOnlyQA, LoadedOnlyPROD);	
	// RETURN SprayedOnly;	
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	;	
