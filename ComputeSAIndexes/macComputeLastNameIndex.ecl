EXPORT macComputeLastNameIndex(dIn, InLastName, JobId, keyName, GCID) := FUNCTIONMACRO
	LOCAL dInLastName	:= dIn((STRING)InLastName <> '');
  
  LOCAL strKeyName      := '~sa::key::' + (STRING)keyName + '::' + (STRING)GCID + '::' + (STRING)JobId;

	LOCAL KeyLastName	:= INDEX(dInLastName, 
		{(string20) InLastName}, 
		{dInLastName}, 
    strKeyName);
		
	RETURN KeyLastName;
ENDMACRO;