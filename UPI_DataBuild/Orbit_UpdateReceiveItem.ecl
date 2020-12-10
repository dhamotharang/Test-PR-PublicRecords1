EXPORT Orbit_UpdateReceiveItem (	  STRING ReceivingID
																	, STRING Status
																	, STRING TokenID
																	, STRING OrbitEnv
																)	:= FUNCTION
	IMPORT UPI_DataBuild.Orbit_Tracking as configQA;
	IMPORT UPI_DataBuild.Orbit_TrackingPROD as configPROD;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'UpdateReceiveItem'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rUpdate		:= 	RECORD
		STRING			orbReceivingId		 						{	XPATH('orb:ReceivingId'									)	}	:= ReceivingId			;
		STRING			orbStatus					 						{	XPATH('orb:Status'											)	}	:= stringlib.StringToUpperCase(Status)						; // 'Received'
	END	;
// -
	rReceive	:= 	RECORD
		rUpdate		orbReceivings										{	XPATH('orb:UpdateReceiveItem'						)	}											;	
	END	;	
	// -
	rLex			:= 	RECORD
		rReceive		orbReceivings									{	XPATH('orb:Receivings'									)	}											;
		STRING 			orbToken 											{	XPATH('orb:Token'												)	}	:= 	TokenID					;	
	END	;
	// -
	rRequest	:= 	RECORD
		$.Orbit_Layouts.AdditionalNamespacesLayout;		
		rLex 				lexRequest										{	XPATH('lex:request'											)	}											;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit 		:= 	RECORD
		STRING			OrbitStatusCode								{	XPATH('OrbitStatusCode'									)	}											;
		STRING			OrbitStatusDescription				{	XPATH('OrbitStatusDescription'					)	}											;
	END;
	//-	
	rResponse := 	RECORD
		rOrbit			OrbitStatus 									{	XPATH('OrbitStatus'											)	}											;
		STRING 			ReceivingId										{	XPATH('ReceivingId'											)	}											;
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
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall_to_use := IF(OrbitEnv = 'QA', OrbitCallQA, OrbitCallPROD);
	OrbitReturn := PROJECT( OrbitCall_to_use,
													TRANSFORM( RECORDOF(LEFT),
																		 SELF.ReceivingId := ReceivingId,
																		 SELF := LEFT));
	// RETURN	OrbitCall;//.OrbitStatus.OrbitStatusCode	;
	// RETURN	OrbitCall.OrbitStatus.OrbitStatusCode	;
	RETURN	IF(OrbitEnv = 'QA', OrbitCallQA.OrbitStatus.OrbitStatusCode, OrbitCallPROD.OrbitStatus.OrbitStatusCode);
	// RETURN	OrbitReturn	;
	// -----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End UpdateReceive Function