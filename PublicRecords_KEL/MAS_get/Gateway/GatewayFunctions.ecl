EXPORT GatewayFunctions := MODULE

	EXPORT GrabGLBPurpose(DummyVariable = '', InvokedByLibrary = TRUE) := FUNCTIONMACRO
		#IF(InvokedByLibrary)
		Result := 0;
		#ELSE
		Result := 0 : STORED('GLBPurposeValue');
		#END
		RETURN Result;
	ENDMACRO;
	
	EXPORT GrabDPPAPurpose(DummyVariable = '', InvokedByLibrary = TRUE) := FUNCTIONMACRO
		#IF(InvokedByLibrary)
		Result := 0;
		#ELSE
		Result := 0 : STORED('DPPAPurposeValue');
		#END
		RETURN Result;
	ENDMACRO;
	
END;