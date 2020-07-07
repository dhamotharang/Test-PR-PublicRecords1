EXPORT Orbit_GetReceivingInstanceStatus (		STRING InstanceID
											, STRING TokenID
										)	:= FUNCTION
IMPORT UPI_DataBuild__dev.Orbit_Tracking as config;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'GetReceivingDetailsByInstance'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rIDs			:= 	RECORD	
		STRING			orbInstanceID		 							{	XPATH('arr:int'													)	}	:= InstanceID			; // '268338'
	END	;
	// -
	rLex			:= 	RECORD
		rIDs				orbInstanceIDs								{	XPATH('orb:InstanceIds'									)	}											;
		STRING 			orbToken 											{	XPATH('orb:Token'												)	}	:= 	TokenID					;	
	END	;
	// -
	rRequest	:= 	RECORD
		rLex 				lexRequest										{	XPATH('lex:request'											)	}											;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit 			:= 	RECORD
		STRING				OrbitStatusCode							{	XPATH('OrbitStatusCode'						)	}																			;
		STRING				OrbitStatusDescription			{	XPATH('OrbitStatusDescription'		)	}																			;	
	END;
	// - 
	rInstanceR	:=	RECORD
		STRING				ReceivingInstanceId					{	XPATH('ReceivingInstanceId'				)	}																			;
		STRING				ReceivingStatus							{	XPATH('ReceivingStatus'						)	}																			;
		STRING				ReceiveDate									{	XPATH('ReceiveDate'						)	}																			;
		STRING				SourceName									{	XPATH('SourceName'								)	}																			;
		STRING				DatasetName									{	XPATH('DatasetName'					)	}																			;
		STRING				ReportingStartDate					{	XPATH('ReportingStartDate'				)	}																			;
		STRING				ReportingEndDate						{	XPATH('ReportingEndDate'					)	}																			;
	END	;
	// - 
	rInstances	:=	RECORD
		rInstanceR		InstanceR										{	XPATH('ReceiveInstanceResponse'		)	}																			;
	END	;
	// -	
	rResponse 	:= 	RECORD
		rInstances		Instances										{	XPATH('Instances'									)	}																			;
		rOrbit				OrbitStatus 								{	XPATH('OrbitStatus'								)	}																			;
		STRING 				OriginalRequest							{	XPATH('OriginalRequest'						)	}																			;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		config.targetURL
													,	config.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(config.OrbitRR(sService)	)
													,	NAMESPACE(config.Namespace_C)
													,	LITERAL
													,	SOAPACTION(config.SoapPath(sService) )
													, RETRY(2)
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// RETURN	OrbitCall.Instances.InstanceR.ReceivingStatus	; // Returns "Receiving Status" only
	RETURN	OrbitCall.Instances.InstanceR	; // Returns "Receiving Status" only
	// RETURN	OrbitCall;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END ; // End VerifyStatusFunction