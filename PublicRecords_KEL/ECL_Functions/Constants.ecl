/*
-99: No LexID or input needed is not populated
-98: No data returned from search
-97: Records available but unable to calculate due to missing values or missing associated/child data
*/
EXPORT Constants := MODULE
  EXPORT STRING MISSING_INPUT_DATA := '-99';
  EXPORT STRING NO_DATA_FOUND := '-98';
  EXPORT STRING RECS_AVAIL_BUT_CANNOT_CALCULATE := '-97';
	
  EXPORT INTEGER MISSING_INPUT_DATA_INT := -99;	
  EXPORT INTEGER NO_DATA_FOUND_INT := -98;	
	
	EXPORT INTEGER DEFAULT_JOIN_LIMIT := 2000;	
END;

