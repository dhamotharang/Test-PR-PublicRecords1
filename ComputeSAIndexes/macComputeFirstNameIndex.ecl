EXPORT macComputeFirstNameIndex(dIn, InFirstName, JobId, keyName, GCID) := FUNCTIONMACRO
	LOCAL dInFirstName	:= dIn((STRING)InFirstName <> '');
  
  LOCAL strKeyName      := '~sa::key::' + (STRING)keyName + '::' + (STRING)GCID + '::' + (STRING)JobId;

	LOCAL KeyFirstName	:= INDEX(dInFirstName, 
		{(string20) InFirstName}, 
		{dInFirstName}, 
    strKeyName);
		
	RETURN KeyFirstName;
ENDMACRO;