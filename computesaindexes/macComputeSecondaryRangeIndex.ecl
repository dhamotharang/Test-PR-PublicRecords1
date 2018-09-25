EXPORT macComputeSecondaryRangeIndex(dIn, InSecondaryRange, JobId, keyName, GCID) := FUNCTIONMACRO
	LOCAL dInSecondaryRange	:= dIn((string)InSecondaryRange <> '');
  
  LOCAL strKeyName      := '~sa::key::' + (STRING)keyName + '::' + (STRING)GCID + '::' + (STRING)JobId;
	
	LOCAL KeySecondaryRange	:= INDEX(dInSecondaryRange, 
		{(string8) InSecondaryRange}, 
		{dInSecondaryRange}, 
    strKeyName);
		
	RETURN KeySecondaryRange;
ENDMACRO;