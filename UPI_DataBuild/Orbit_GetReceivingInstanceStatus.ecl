EXPORT Orbit_GetReceivingInstanceStatus (		STRING InstanceID
											, STRING TokenID
											, STRING OrbitEnv
										)	:= FUNCTION
IMPORT UPI_DataBuild.Orbit_Tracking as configQA;
IMPORT UPI_DataBuild.Orbit_TrackingPROD as configPROD;
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
	OrbitCallQA	:=	SOAPCALL(		configQA.targetURL
													,	configQA.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(configQA.OrbitRR(sService)	)
													,	NAMESPACE(configQA.Namespace_C)
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
													,	NAMESPACE(configPROD.Namespace_C)
													,	LITERAL
													,	SOAPACTION(configPROD.SoapPath(sService) )
													, RETRY(2)
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// RETURN	OrbitCall.Instances.InstanceR.ReceivingStatus	; // Returns "Receiving Status" only
	// RETURN	OrbitCall.Instances.InstanceR	; // Returns "Receiving Status" only
	RETURN	IF(OrbitEnv = 'QA', OrbitCallQA.Instances.InstanceR, OrbitCallPROD.Instances.InstanceR)	; // Returns "Receiving Status" only
	// RETURN	OrbitCall;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END ; // End VerifyStatusFunction