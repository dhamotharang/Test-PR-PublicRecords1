EXPORT Orbit_UpdateReceiveItem (	  STRING ReceivingID
																	, STRING Status
																	, STRING TokenID
																)	:= FUNCTION
	IMPORT UPI_DataBuild__dev.Orbit_Tracking as config;
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
	OrbitCall	:=	SOAPCALL(		config.targetURL
													,	config.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(config.OrbitRR(sService)	)
													,	NAMESPACE(config.Namespace_D)
													,	LITERAL
													,	SOAPACTION(config.SoapPath(sService) )
													, RETRY(2)
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitReturn := PROJECT( OrbitCall,
													TRANSFORM( RECORDOF(LEFT),
																		 SELF.ReceivingId := ReceivingId,
																		 SELF := LEFT));
	// RETURN	OrbitCall;//.OrbitStatus.OrbitStatusCode	;
	RETURN	OrbitCall.OrbitStatus.OrbitStatusCode	;
	// RETURN	OrbitReturn	;
	// -----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End UpdateReceive Function