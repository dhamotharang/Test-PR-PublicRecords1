EXPORT macComputeProviderKeyIndex(dIn, InProviderKey, JobId, keyName, GCID) := FUNCTIONMACRO
	LOCAL dInProviderKey	:= dIn((string)InProviderKey <> '');
  
  LOCAL strKeyName      := '~sa::key::' + (STRING)keyName + '::' + (STRING)GCID + '::' + (STRING)JobId;
	
	LOCAL KeyProviderKey	:= INDEX(dInProviderKey, 
		{(string50) InProviderKey}, 
		{dInProviderKey}, 
    strKeyName);
		
	RETURN KeyProviderKey;
ENDMACRO;