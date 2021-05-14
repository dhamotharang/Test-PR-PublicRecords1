IMPORT UPI_DataBuild__dev.Orbit_TrackingPROD as config;

EXPORT Orbit_LoginPROD (		STRING UserName  = config.OrbitUser
										,	STRING Password  = config.OrbitPassword
										,	STRING TargetURL = config.targetURL     // system constants should set this based on dali
										,	STRING Domain 	 = config.Domain
									)	:= FUNCTION

	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'LoginSBFE'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	rRequest	:= 	RECORD
			$.Orbit_Layouts.AdditionalNamespacesLayout;	
			STRING		OrbitDomain			{	XPATH('lex:orbitDomain'												)	}		:=	Domain				;
			STRING 		OrbitUsername 	{	XPATH('lex:userName'													)	}		:=	UserName			;
			STRING		OrbitPassword 	{	XPATH('lex:password'													)	}		:=	Password			;								
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	rResponse	:=	RECORD
			STRING		OrbitToken			{	XPATH(config.OrbitRR(sService)	)	}											;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		TargetURL
													,	sService
													,	rRequest
													,	rResponse
													,	NAMESPACE(config.Namespace)
													,	LITERAL
													,	SOAPACTION(config.SoapPath(sService) )
													, RETRY(2)
													, LOG
												)	: GLOBAL	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	RETURN	OrbitCall.OrbitToken; // Returns only the token string
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	; // End LoginSBFE Function