export macMapState(

	 pState
	,pVersion	
	,pOutput
	,pCotmVersion		= ''
	,pDebugMode			= 'false' 
	,pSuffix				= '\'\''   
	,pshouldspray 	= 'false' 
	,pOverwrite			= 'false'


) :=
macro
	pOutput :=
	Corp2_Mapping.MapStates(
		 pVersion
		,pCotmVersion	
		,pDebugMode		
		,pSuffix			
		,pshouldspray 
		,pOverwrite		
	).pState;

endmacro;