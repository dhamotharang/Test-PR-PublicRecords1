EXPORT macComputePrimaryRangeIndex(dIn, InPrimaryRange, JobId, keyName, GCID) := FUNCTIONMACRO
	LOCAL dInPrimaryRange	:= dIn((string)InPrimaryRange <> '');
  
  LOCAL strKeyName      := '~sa::key::' + (STRING)keyName + '::' + (STRING)GCID + '::' + (STRING)JobId;
	
	LOCAL KeyPrimaryRange	:= INDEX(dInPrimaryRange, 
		{(string10) InPrimaryRange}, 
		{dInPrimaryRange}, 
    strKeyName);
		
	RETURN KeyPrimaryRange;
ENDMACRO;