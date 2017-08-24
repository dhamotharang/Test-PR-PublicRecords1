import BairRx_Common;
EXPORT FetchLimit(inDS, max_records, 	errCode = BairRx_Common.STDError.TooManyRecords) := FUNCTIONMACRO
	RETURN LIMIT(inDS, max_records, FAIL(errCode, BairRx_Common.STDError.GetMessage(errCode)));	
ENDMACRO;