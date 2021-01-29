EXPORT GatewayFunctions := MODULE

		EXPORT GrabGLBPurpose(DummyVariable = '') := FUNCTIONMACRO
			Result := 0 : STORED('GLBPurposeValue');
			RETURN Result;
		ENDMACRO;

		EXPORT GrabDPPAPurpose(DummyVariable = '') := FUNCTIONMACRO
			Result := 0 : STORED('DPPAPurposeValue');
			RETURN Result;
		ENDMACRO;

		EXPORT GrabWatchlistsRequested(DummyVariable = '') := FUNCTIONMACRO
			Result := '' : STORED('Watchlists_RequestedValue');
			RETURN Result;
		ENDMACRO;

		EXPORT GrabIncludeOFAC(DummyVariable = '') := FUNCTIONMACRO
			Result := FALSE : STORED('IncludeOfacValue');
			RETURN Result;
		ENDMACRO;

		EXPORT GrabIncludeAdditionalWatchlists(DummyVariable = '') := FUNCTIONMACRO
			Result := FALSE : STORED('IncludeAdditionalWatchListsValue');
			RETURN Result;
		ENDMACRO;

		EXPORT GrabGlobalWatchlistThreshold(DummyVariable = '') := FUNCTIONMACRO
			Result := 0.84 : STORED('Global_Watchlist_ThresholdValue');
			RETURN Result;
		ENDMACRO;
		
		EXPORT GrabIsFCRA(DummyVariable = '') := FUNCTIONMACRO
			Result := FALSE : STORED('IsFCRAValue');
			RETURN Result;
		ENDMACRO;
	
END;