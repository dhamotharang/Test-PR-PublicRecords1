EXPORT macComputeProviderNpiIndex(dIn, InProviderNpi, JobId, keyName, GCID) := FUNCTIONMACRO
	LOCAL dInProviderNpi	:= dIn((string)InProviderNpi <> '');
  
  LOCAL strKeyName      := '~sa::key::' + (STRING)keyName + '::' + (STRING)GCID + '::' + (STRING)JobId;

	LOCAL KeyProviderNpi	:= INDEX(dInProviderNpi, 
		{(string10) InProviderNpi}, 
		{dInProviderNpi}, 
    strKeyName);
		
	RETURN KeyProviderNpi;
ENDMACRO;