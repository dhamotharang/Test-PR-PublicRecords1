EXPORT STDError := MODULE

	EXPORT SearchTooBroad             := 11;	
	EXPORT MinCriteriaRequired        := 100;	
	EXPORT NotValidStartDate					:= 101;
	EXPORT NotValidEndDate						:= 102;
	EXPORT InvalidDateRange						:= 103;
	EXPORT InvalidPolygon							:= 104;
	EXPORT MissingAgencyORI						:= 105;
	EXPORT TooManyRecords							:= 203;
	EXPORT TooManyGeoRecords					:= 204;
	EXPORT TooManyPayloadRecords			:= 205;
	
	EXPORT GetMessage(integer code) := MAP(
		code = SearchTooBroad 							=> 'Search is too broad',
		code = MinCriteriaRequired 					=> 'Minimum criteria required',
		code = NotValidStartDate 						=> 'Invalid start date',
		code = NotValidEndDate 							=> 'Invalid end date',
		code = InvalidDateRange 						=> 'Invalid date range',
		code = InvalidPolygon 							=> 'Invalid polygon provided',
		code = MissingAgencyORI 						=> 'Missing required Agency ORI',
		code = TooManyRecords 							=> 'Too many records found', // different codes, same message
		code = TooManyGeoRecords 						=> 'Too many records found',
		code = TooManyPayloadRecords 				=> 'Too many records found',
		''
		);
	
	// Conditional fail
	EXPORT CFail(boolean failCond, integer code) := IF(failCond, FAIL(code, GetMessage(code)));		
	// Force fail
	EXPORT FFail(integer code) := FAIL(code, GetMessage(code));		
	
END;